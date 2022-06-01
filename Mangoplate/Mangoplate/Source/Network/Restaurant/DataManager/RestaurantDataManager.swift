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
          viewController.dismissIndicator()
        }
      }
  }
  
  
  // 맛집찾기 식당 목록
  func getRestaurant(parameters: RestaurantRequest, viewController: ThirdRestaurantDetailCell) {
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
  
  func getDetailRestaurant(storeId: Int, viewController: RestaurantViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/stores/\(storeId)/info", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: DetailRestaurantResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            guard let detailresult = result.result else { return }
            viewController.successGetDetailRestaurants(detailrestaurantResult: detailresult)
          } else {
            viewController.failedGetDetailRestaurants(message: result.message)
          }
        case .failure(let error):
          print("getDetailRestaurant failure \(error.localizedDescription)")
          viewController.dismissIndicator()
          viewController.presentAlert(title: "아직 데이터가 없어요!")
        }
      }
  }
  
}
