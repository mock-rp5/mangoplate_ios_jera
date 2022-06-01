//
//  ReviewWritingRequest.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import Foundation

struct reviewWritingRequest: Codable {
  var storeId: Int
  var feedContent: String
  var evaluation: Int
  var reviewImg: [Data]?
}
