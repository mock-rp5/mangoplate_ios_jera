//
//  LikeResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import Foundation
struct LikeResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: LikeResult
}

struct LikeResult: Codable {
  let action: String
}
