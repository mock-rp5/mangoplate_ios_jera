//
//  AppDelegate.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit
import Photos
import KakaoSDKCommon

var allPhotos: PHFetchResult<PHAsset>? = nil
var photocount = Int()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    KakaoSDK.initSDK(appKey: "9e0f03f667c2a87d4cabc3baed37769e")
    
    // 커스텀 갤러리를 위해 갤러리의 이미지들과 이미지 갯수 받아옴
    PHPhotoLibrary.requestAuthorization { (status) in
      switch status {
      case .notDetermined:
        print("notDetermined")
      case .restricted:
        print("restricted")
      case .denied:
        print("denied")
      case .authorized:
        print("good to proceed")
        let fetchOptions = PHFetchOptions()
        allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        photocount = allPhotos?.count ?? 0
      case .limited:
        print("limited")
      }
    }
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

