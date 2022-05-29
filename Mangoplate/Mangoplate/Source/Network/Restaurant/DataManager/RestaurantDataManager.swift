//
//  RestaurantDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Alamofire
import UIKit
import Pageboy

class RestaurantDataManager {
  func getAreas(viewController: RestaurantViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/areas", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: AreasResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetAreas(areaResults: result.result)
          } else {
            viewController.failedGetAreas(message: result.message)
          }

        case .failure(let error):
          
          print("getAreas eror: \(error.localizedDescription)")
        }
      }
  }
  
  // 맛집찾기 식당 목록 
  func getRestaurant(parameters: RestaurantRequest, viewController: RestaurantViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/stores", method: .get, parameters: parameters, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: RestaurantResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetRestaurants(restaurantResult: result.result ?? [])
          }
        case .failure(let error):
          print("getRestaurant failure \(error.localizedDescription)")
        }
      }
  }
}
