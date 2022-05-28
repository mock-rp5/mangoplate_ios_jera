//
//  TopListResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import Foundation

struct TopListResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [TopListResult]?
}

// MARK: - Result
struct TopListResult: Codable {
  let topListId: Int
  let topListTitle, topListSubTitle: String
  let topListThumbnailUrl: String?
  let viewCount: Int
  let createDate: String
}
