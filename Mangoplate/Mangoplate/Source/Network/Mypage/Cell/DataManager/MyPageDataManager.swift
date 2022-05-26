//
//  MyPageDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Foundation
import Alamofire

class MyPageDataManager {
  
  // 회원 탈퇴
  func deleteUser(viewController: UserDeleteViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/users", method: .delete, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: DeleteUserResponse.self) { response in
        print(response)
        print("jwt: \(Constant.HEADERS)")
        switch response.result {
        case .success(let data):
          if data.isSuccess {
            viewController.successDeleteUser(message: data.message)
          } else {
            viewController.failedDeleteUser(message: data.message)
          }
          
        case .failure(let error):
          print(error.localizedDescription)
        }
        
      }
      
  }
}
