//
//  ReviewWritingResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import Foundation

struct ReviewWritingResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: ReviewWritingResult?
}


struct ReviewWritingResult: Codable {
  let postId: Int
}
