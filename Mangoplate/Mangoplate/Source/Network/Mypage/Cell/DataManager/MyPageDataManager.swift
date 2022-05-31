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
  
  func getUser(viewController: UIViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/users", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: GetUserResponse.self) { response in
        switch response.result {
        case .success(let result):
          
          // MyPageVC에서 회원 정보 조회
          if viewController is MypageViewController {
            let vc = viewController as? MypageViewController
            if result.isSuccess {
              if let user = result.result?.first {
                vc?.successGetUser(user: user)
              } else {
                vc?.failedGetUser(message: result.message)
              }
            }
          }
          
          // UserDeleteVC 에서 회원 정보 조회
          else if viewController is UserDeleteViewController {
            let vc = viewController as? UserDeleteViewController
            if result.isSuccess {
              if let user = result.result?.first {
                vc?.successGetUser(user: user)
              } else {
                vc?.failedGetUser(message: result.message)
              }
            }
          }
          
        case .failure(let error):
          print("getUser failure \(error.localizedDescription)")
        }
      }
    }
}
