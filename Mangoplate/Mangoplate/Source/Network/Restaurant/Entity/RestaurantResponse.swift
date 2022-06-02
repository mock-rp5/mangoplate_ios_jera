//
//  RestaurantResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation

struct RestaurantResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [RestaurantResult]?
}

struct RestaurantResult: Codable {
  let storeId: Int
  let storeName: String
  let areaId: Int
  let areaName: String
  let detailAreaId: Int
  let detailAreaName: String
  let foodTypeId: Int
  let foodTypeName: String
  let detailFoodTypeId: Int
  let detailFoodTypeName: String
  let reviewCount: Int
  let thumbnailImgUrl: String?
  let score: String?
  let isValidatedScore: Int
  let viewCount: Int
  let distance: Float?
  let isFavoriteStore: Int
}
