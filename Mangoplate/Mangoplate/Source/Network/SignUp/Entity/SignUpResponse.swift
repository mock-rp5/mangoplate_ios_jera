//
//  UserRegister.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation

//  {
//      "isSuccess": true,
//      "code": 1000,
//      "message": "성공",
//      "result": {
//          "userId": 9
//      }
//  }

struct SignUpResponse: Codable {
  var isSuccess: Bool
  var code: Int
  var message: String
  var result: Result?
}

struct Result: Codable {
  var userId: Int
}
