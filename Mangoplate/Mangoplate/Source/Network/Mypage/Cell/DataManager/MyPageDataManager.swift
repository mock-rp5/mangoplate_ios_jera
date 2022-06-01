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
  
  // 내가 쓴 리뷰 조회
  func getMyReview(_ parameters: FeedRequest, viewController: MyReviewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/feeds/\(Constant.USER_ID)/reviews", method: .get, parameters: parameters,  headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: FeedResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetMyReview(results: result.result ?? [])
          } else {
            viewController.failedGetMyReview(message: result.message)
          }
          
        case .failure(let error):
          print("getMyReview failure \(error.localizedDescription)")
          viewController.dismissIndicator()
        }
      }
  }
  
  
  // 리뷰 삭제
  func deleteMyReview(postId: Int, viewController: DeleteReviewController) {
    viewController.showIndicator()
    AF.request("\(Constant.DEV_BASE_URL)/app/feeds/reviews/\(String(postId))",method: .delete, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: DeleteReviewResponse.self) { response in
        print(response)
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successDeleteReview()
            viewController.dismissIndicator()
          } else {
            viewController.failedDeleteReview(message: result.message)
            viewController.dismissIndicator()
          }
          
        case .failure(let error):
          print("deleteMyReview failure \(error.localizedDescription)")
          viewController.dismissIndicator()
        }
      }
  }
}
