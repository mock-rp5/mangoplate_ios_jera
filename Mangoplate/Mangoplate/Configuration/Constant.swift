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
  static let USER_ID = UserDefaults.standard.object(forKey: "userID") as! String
  
  //static var HEADERS: HTTPHeaders = ["x-access-token": UserDefaults.standard.object(forKey: "jwtKey") as! String]
  static var HEADERS: HTTPHeaders {
    let jwtKey = getJwtKey()
    return ["x-access-token": jwtKey]
  }
  
  static func getJwtKey() -> String {
    let jwtKey = UserDefaults.standard.object(forKey: "jwtKey") as! String
    if jwtKey == "logout" {
      let logoutKey = """
      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjM4LCJpYXQiOjE2NTQxNzY4NDUsImV4cCI6MTY4NTcxMjg0NSwic3ViIjoidXNlckluZm8ifQ.R39PJAzsXL-6YcwAF9bpG19YqopegbwOm3Ulm1JVdZ8
      """
      return logoutKey
    }
    else {
      return jwtKey
    }
  }

}
