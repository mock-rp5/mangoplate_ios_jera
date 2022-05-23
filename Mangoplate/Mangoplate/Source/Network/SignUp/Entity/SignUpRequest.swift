//
//  SignUpRequest.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import Foundation
import UIKit

struct SignUpRequest: Codable {
  var email: String
  var password: String
  var nickName: String
  var profileImg: Data?
}
