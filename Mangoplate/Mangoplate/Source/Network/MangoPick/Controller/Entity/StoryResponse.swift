//
//  StoryResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation

struct StoryResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: [StoryResult]?
}

// MARK: - Result
struct StoryResult: Codable {
  let storyId: Int
  let storyTitle, storySubTitle: String
  let storythumbnailUrl: String?
}
