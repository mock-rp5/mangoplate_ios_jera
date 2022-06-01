//
//  DetailRestaurantResponse.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import Foundation

struct DetailRestaurantResponse: Codable {
  let isSuccess: Bool
  let code: Int
  let message: String
  let result: DetailRestaurantResult?
}


struct DetailRestaurantResult: Codable {
    let storeId: Int
    let storeName: String
    let viewCount, favoriteCount, reviewCount, isLiked: Int
    let storeAddress, storeLandAddress, foodTypeName, score: String
    let isValidatedScore: Int
    let storePhotos: [StorePhoto]
    let storeDetail: StoreDetail
    let storeMenu: StoreMenu
    let storeEvaluation: StoreEvaluation
    let storeReview: [StoreReview]
}

// MARK: - StoreDetail
struct StoreDetail: Codable {
    let storeOpenTime, storeRestTime, storeClose: String
    let canCorkage: Int
    let corkageInfo: String?
    let priceInfo, hasParking: String
    let parkingInfo: String?
    let storeURL: String
    let regUserId: String?
    let updateDate: String
}

// MARK: - StoreEvaluation
struct StoreEvaluation: Codable {
    let evaluationCount, badCount, goodCount, veryGoodCount: Int
}

// MARK: - StoreMenu
struct StoreMenu: Codable {
    let updateDate: String
    let menus: [Menu]
    let menuphotos: [Menuphoto]
}

// MARK: - Menuphoto
struct Menuphoto: Codable {
    let postId: Int
    let photoUrl: String
}

// MARK: - Menu
struct Menu: Codable {
    let storeMenuName: String
    let price, isMainMenu: Int
}

// MARK: - StorePhoto
struct StorePhoto: Codable {
    let postId, postPhotoId: Int
    let photoUrl: String
}

// MARK: - StoreReview
struct StoreReview: Codable {
    let postId, storeId: Int
    let feedContent: String
    let evaluation, isFavoriteStore, isLike, likeCount: Int
    let commentCount: Int
    let createDate: String
    let photos: [Photo]
}



