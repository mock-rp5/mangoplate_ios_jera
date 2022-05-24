//
//  SignInResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import Foundation

struct SignInResponse: Codable {
  var isSuccess: Bool
  var code: Int
  var message: String
  var result: SignInResult?
}

struct SignInResult: Codable {
  var userId: Int
  var jwt: String
}
