//
//  NewsDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/30.
//

import Foundation
import UIKit
import Alamofire

class NewsDataManager {
  
  // 피드 조회
  func getFeed(_ parameters: FeedRequest, viewController: AllViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/feeds", method: .get, parameters: parameters, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: FeedResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetFeed(results: result.result ?? [])
          } else {
            viewController.failedGetFeed(message: result.message)
          }
          
        case .failure(let error):
          print("getFeed failure \(error.localizedDescription)")
          viewController.dismissIndicator()
        }
      }
  }
}
  
