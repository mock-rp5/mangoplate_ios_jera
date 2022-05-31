//
//  Review.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import Foundation
import UIKit

class Review {
  static let shared = Review()
  var storeId: Int?
  var images: [Data]?
  var evaluation: Int?
  var content: String?
}
