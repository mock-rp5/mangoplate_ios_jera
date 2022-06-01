//
//  WritingDataManager.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import Foundation
import Alamofire

class WritingDataManager {
  // 전체 식당 목록 조회
  func getStores(viewController: ReviewStoresViewController) {
    AF.request("\(Constant.DEV_BASE_URL)/app/stores/search", method: .get, headers: Constant.HEADERS)
      .validate()
      .responseDecodable(of: StoreSearchResponse.self) { response in
        switch response.result {
        case .success(let result):
          if result.isSuccess {
            viewController.successGetStores(results: result.result ?? [])
          } else {
            viewController.failedGetStores(message: result.message)
          }
          
        case .failure(let error):
          print("getStores failure \(error.localizedDescription)")
          viewController.dismissIndicator()
        }
      }
  }
  
  func postReview(_ parameters: reviewWritingRequest, viewController: ReviewWritingViewController) {
    viewController.showIndicator()
    
    let header: HTTPHeaders = [
      "Content-Type": "multipart/form-data",
      "x-access-token": UserDefaults.standard.object(forKey: "jwtKey") as! String
    ]
    
    AF.upload(multipartFormData: { multipartFormData in
      //multipartFormData.append("\(parameters.storeId)".dataUsingEncoding(String.Encoding.utf8)!, withName: "")
      multipartFormData.append("\(parameters.storeId)".data(using: .utf8)!, withName: "storeId")
      multipartFormData.append(parameters.feedContent.data(using: .utf8)!, withName: "feedContent")
      multipartFormData.append("\(parameters.evaluation)".data(using: .utf8)!, withName: "evaluation")
      
      if let reviewImg = parameters.reviewImg {
        for img in reviewImg {
          multipartFormData.append(img, withName: "reviewImg",
                                   fileName:"review.jpeg", mimeType: "image/jpeg")
        }
      }
      
    }, to: "\(Constant.DEV_BASE_URL)/app/feeds/reviews",usingThreshold: UInt64.init(), method: .post, headers: header)
        .responseDecodable(of: ReviewWritingResponse.self) { response in
          print("postReview \(response)")
          switch response.result {
          case .success(let response):
            if response.isSuccess {
              print("success postReivew \(response)")
              viewController.successPostReview()
              viewController.dismissIndicator()
            } else {
              viewController.faliedPostReview(message: response.message)
              viewController.dismissIndicator()
            }
          
          case .failure(let error):
            print("failure postReview \(error.localizedDescription)")
            viewController.dismissIndicator()
          }
        }
  }
  
  
  
}
