//
//  User.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation
import UIKit

class User {
  static let shared: User = User()
  var email: String?
  var password: String?
  var nickName: String?
  var profile: UIImage?
}
