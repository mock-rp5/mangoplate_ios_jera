//
//  SignUpDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation
import Alamofire

class SignUpDataManager {
  func signUp(_ parameters: SignUpRequest, viewController: SecondSignUpViewController) {
    
    let header: HTTPHeaders = [
      "Content-Type": "multipart/form-data"
    ]
    
    AF.upload(multipartFormData: { multipartFormData in
      multipartFormData.append(parameters.email.data(using: .utf8)!, withName: "email")
      multipartFormData.append(parameters.password.data(using: .utf8)!, withName: "password")
      multipartFormData.append(parameters.nickName.data(using: .utf8)!, withName: "nickName")
      
      if let profile = parameters.profileImg {
        multipartFormData.append(profile, withName: "profileImg",
                                 fileName:"\(parameters.nickName).jpeg", mimeType: "image/jpeg")
      } else {
        multipartFormData.append("".data(using: .utf8)!, withName: "profileImg", fileName: "", mimeType: "")
      }
    }, to: "\(Constant.DEV_BASE_URL)/app/users/email-register",usingThreshold: UInt64.init(), method: .post, headers: header)
        .responseDecodable(of: SignUpResponse.self) { response in
          switch response.result {
          case .success(let response):
            if response.isSuccess, let result = response.result {
              viewController.successSignUp(result: result)
            } else {
              viewController.failedSignUp(message: response.message)
            }
  
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
  }
  
  func emailCheck(_ parameters: EmailCheckRequest, viewController: FirstSignUpViewController) {
    
    AF.request("\(Constant.DEV_BASE_URL)/app/users/email-check", method: .get, parameters: parameters)
      .validate()
      .responseDecodable(of: SignUpResponse.self) { response in
        switch response.result {
        case .success(let response):
          if response.isSuccess {
            viewController.successEmailCheck()
          } else {
            viewController.failedEmailCheck(message: response.message)
          }

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
  }
}
