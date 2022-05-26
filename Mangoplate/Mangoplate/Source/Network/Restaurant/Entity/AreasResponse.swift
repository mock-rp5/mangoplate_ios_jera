//
//  AreasResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import Foundation

struct AreasResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [AreasResult]
}

// MARK: - Result
struct AreasResult: Codable {
  let areaId: Int
  let areaName: String
  let detailAreas: [DetailArea]
}

// MARK: - DetailArea
struct DetailArea: Codable {
  let detailAreaId: Int
  let detailAreaName: String
}
