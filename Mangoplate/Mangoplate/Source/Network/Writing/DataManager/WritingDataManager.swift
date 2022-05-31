//
//  WritingDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import Foundation
import Alamofire

class WritingDataManager {
  // 전체 식당 목록 조회
  func getStores(viewController: ReviewStoresViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/stores/search", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: StoreSearchResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetStores(results: result.result ?? [])
          } else {
            viewController.failedGetStores(message: result.message)
          }
          
        case .failure(let error):
          print("getStores failure \(error.localizedDescription)")
          viewController.dismissIndicator()
        }
      }
  }
}
