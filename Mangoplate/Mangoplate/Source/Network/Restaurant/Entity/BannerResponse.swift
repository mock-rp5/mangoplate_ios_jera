//
//  BannerResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import Foundation

struct BannerResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [BannerResult]
}

// MARK: - Result
struct BannerResult: Codable {
    let adBannerId: Int
    let adBannerImgUrl: String
}

