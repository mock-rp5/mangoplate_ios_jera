//
//  GetUserResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import Foundation

struct GetUserResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [GetUserResult]?
}

// MARK: - Result
struct GetUserResult: Codable {
  let userId: Int
  let userName: String
  let userProfileImg: String?
  let isHolic, following, follower, reviewCount, visitCount: Int
  let userEmail: String?
  let userPhone: String?
  let status: String?
  let userFavCount: Int
}
