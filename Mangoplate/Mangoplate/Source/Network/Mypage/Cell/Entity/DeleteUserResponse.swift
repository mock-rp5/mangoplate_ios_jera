//
//  DeleteUserResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Foundation

struct DeleteUserResponse: Decodable {
  var isSuccess: Bool
  var code: Int
  var message: String
}
