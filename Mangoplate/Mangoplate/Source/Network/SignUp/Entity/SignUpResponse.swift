//
//  UserRegister.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation

struct SignUpResponse: Codable {
  var isSuccess: Bool
  var code: Int
  var message: String
  var result: SignUpResult?
}

struct SignUpResult: Codable {
  var userId: Int
}
