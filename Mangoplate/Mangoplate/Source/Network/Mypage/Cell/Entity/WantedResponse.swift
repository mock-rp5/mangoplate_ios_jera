//
//  WantedResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import Foundation

struct WantedResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [WantedResult]
}

// MARK: - Result
struct WantedResult: Codable {
  let storeId: Int
  let storeName, detailAreaName: String
  let viewCount, isFavorite, reviewCount: Int
  let thumbnailImgUrl: String
  let score: String
}
