//
//  SginInDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import Foundation
import UIKit
import Alamofire

class SignInDataManger {
  
  // 이메일 로그인
  func signIn(_ parameters: SignInRequest, viewController: EmailSignInViewController) {
    
    AF.request("\(Constant.DEV_BASE_URL)/app/users/email-login", method: .post, parameters: parameters)
      .validate()
      .responseDecodable(of: SignInResponse.self) { response in
        switch response.result {
        case .success(let response):
          if response.isSuccess {
            if let jwt = response.result?.jwt,
               let userID = response.result?.userId {
              viewController.successSignIn(jwtKey: jwt, userID: String(userID))
            }
          } else {
            viewController.failedSignIn(message: response.message, code: response.code)
          }
        case .failure(let error):
          viewController.presentAlert(title: "일시적 오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
          print(error.localizedDescription)
        }
      }
  }
  
  // 카카오 로그인
  func kakaoLogin(_ parameters: KakaoLoginRequest, viewController: SignInHomeViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/users/kakao-login", method: .post, parameters: parameters)
      .validate()
      .responseDecodable(of: SignInResponse.self) { response in
        switch response.result {
        case .success(let response):
          if response.isSuccess {
            viewController.successKakaoLogin(jwtKey: response.result?.jwt ?? "")
          }
        
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
  }
}
