//
//  Constant.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation
import Alamofire

struct Constant {
  static let DEV_BASE_URL = "https://devmp.eric-rc.shop"
  static let PROD_BASE_URL = "https://prodmp.eric-rc.shop"
  
  static var HEADERS: HTTPHeaders = ["x-access-token": UserDefaults.standard.object(forKey: "jwtKey") as! String]
}
