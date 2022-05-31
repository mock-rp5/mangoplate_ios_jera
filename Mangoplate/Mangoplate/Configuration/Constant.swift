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
  
  //static var HEADERS: HTTPHeaders = ["x-access-token": UserDefaults.standard.object(forKey: "jwtKey") as! String]
  static var HEADERS: HTTPHeaders {
    let jwtKey = getJwtKey()
    return ["x-access-token": jwtKey]
  }
  
  static func getJwtKey() -> String {
    let jwtKey = UserDefaults.standard.object(forKey: "jwtKey") as! String
    if jwtKey == "logout" {
      let logoutKey = """
      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMxLCJpYXQiOjE2NTM5OTQzNDksImV4cCI6MTY4NTUzMDM0OSwic3ViIjoidXNlckluZm8ifQ.y3Q_Q2kwf3aSPJqbZPw7IffRiODbGcE8vjbEONT8Ns0
      """
      return logoutKey
    }
    else {
      return jwtKey
    }
  }

}
