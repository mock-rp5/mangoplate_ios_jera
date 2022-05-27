//
//  RestaurantDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Alamofire
import UIKit

class RestaurantDataManager {
  func getAreas(viewController: RestaurantViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/areas", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: AreasResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.showIndicator()
            viewController.successGetAreas(areaResults: result.result)
            viewController.dismissIndicator()
          } else {
            viewController.failedGetAreas(message: result.message)
          }

        case .failure(let error):
          
          print("getAreas eror: \(error.localizedDescription)")
        }
      }
  }
}
