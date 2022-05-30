//
//  RestaurantRequest.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation

struct RestaurantRequest: Codable {
  var page: Int?
  var pagesize: Int?
  var area: String?
  var detailarea: String?
  var x: Float?
  var y: Float?
}
