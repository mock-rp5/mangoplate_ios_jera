//
//  MangoPicksDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import Foundation
import Alamofire

class MangoPickDataManager {
  
  // EAT딜 조회
  func getEATDeal(viewController: EATDealViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/mangopicks/eatdeal", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: EATDealResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.succeessGetEATDeal(results: result.result ?? [])
          } else {
            viewController.failedGetEATDeal(message: result.message)
          }
          
        case .failure(let error):
          print("getEATDeal failure \(error.localizedDescription)")
        }
      }
  }
  
  // 스토리 조회
  func getStory(viewController: StoryViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/mangopicks/story", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: StoryResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetStory(results: result.result ?? [])
          } else {
            viewController.failedGetStory(message: result.message)
          }
          
        case .failure(let error):
          print("getEATDeal failure \(error.localizedDescription)")
        }
      }
  }
  
  // Top리스트 조회
  func getTopList(viewController: TopListViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/mangopicks/toplist", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: TopListResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetTopList(results: result.result ?? [])
          } else {
            viewController.failedGetTopList(message: result.message)
          }
          
        case .failure(let error):
          print("getEATDeal failure \(error.localizedDescription)")
        }
      }
  }
}
