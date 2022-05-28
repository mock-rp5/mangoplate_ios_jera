//
//  MangoPicksDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation
import Alamofire

class MangoPickDataManager {
  func getEATDeal(viewController: EATDealViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/mangopicks/eatdeal", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: EATDealResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.showIndicator()
            viewController.succeessGetEATDeal(results: result.result)
            viewController.dismissIndicator()
          }
          
        case .failure(let error):
          print("getEATDeal failure \(error.localizedDescription)")
        }
      }
  }
}
