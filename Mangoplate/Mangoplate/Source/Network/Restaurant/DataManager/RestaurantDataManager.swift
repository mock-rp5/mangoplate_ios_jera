//
//  RestaurantDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Alamofire
import UIKit

class RestaurantManager {
  func getAreas(viewController: UIViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/areas", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: AreasResponse.self) { response in
        print(response)
//        switch response.result {
//        case .success(let response):
//          if response.isSuccess {
//            viewController.successEmailCheck()
//          } else {
//            viewController.failedEmailCheck(message: response.message)
//          }
//
//        case .failure(let error):
//          print(error.localizedDescription)
//        }
      }
  }
}
