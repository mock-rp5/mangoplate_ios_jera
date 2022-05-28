//
//  MangoPicksResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation

struct EATDealResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [EATDealResult]?
}

struct EATDealResult: Codable {
  let eatDealId: Int
  let storeName, menuName: String
  let eatDealComment: String?
  let discount: String
  let originalPrice, salePrice: Int
  let thumbnailPhotoUrl: String?
  let isNew: Int

}
