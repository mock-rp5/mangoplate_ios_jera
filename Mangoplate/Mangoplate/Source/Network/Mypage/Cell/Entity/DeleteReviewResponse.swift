//
//  DeleteReviewResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import Foundation

struct DeleteReviewResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
}
