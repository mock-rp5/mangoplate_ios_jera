//
//  DetailRestaurantViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class DetailRestaurantViewController: BaseViewController {

  @IBOutlet weak var detailRestaurantCollectionView: UICollectionView!
  var navigationTitle: String?
  var detailRestaurant: DetailRestaurantResult?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigaionItem()
  
    detailRestaurantCollectionView.register(UINib(nibName: "FirstRestaurantDetailCell", bundle: .main), forCellWithReuseIdentifier: "FirstRestaurantDetailCell")
    detailRestaurantCollectionView.register(UINib(nibName: "SecondRestaurantDetailCell", bundle: .main), forCellWithReuseIdentifier: "SecondRestaurantDetailCell")
    detailRestaurantCollectionView.register(UINib(nibName: "ThirdRestaurantDetailCell", bundle: .main), forCellWithReuseIdentifier: "ThirdRestaurantDetailCell")
    detailRestaurantCollectionView.delegate = self
    detailRestaurantCollectionView.dataSource = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    BaseTabBarController.showTabBar()
  }
  
  func setNavigaionItem() {
    self.navigationController?.navigationBar.isTransparent = true
    self.setNavigationBarBackbuttonTitle(title: detailRestaurant?.storeName ?? "")
    self.navigationController?.navigationBar.tintColor = .mainOrange
   
    UINavigationBar.appearance().tintColor = .mainOrange
    
    let cameraButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "camera", imageName: nil, tintColor: .mainOrange, width: 30, height: 25)
    let shareButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "square.and.arrow.up", imageName: nil, tintColor: .mainOrange, width: 30, height: 25)
    
    self.navigationItem.rightBarButtonItems = [shareButton, cameraButton]
  }
}

extension DetailRestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = detailRestaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "FirstRestaurantDetailCell", for: indexPath) as? FirstRestaurantDetailCell else {
        return UICollectionViewCell() }
      if let detailRestaurant = detailRestaurant {
        cell.storeLabel.text = detailRestaurant.storeName
        cell.watchingLabel.text = String(detailRestaurant.viewCount).insertComma
        cell.reviewLabel.text = String(detailRestaurant.reviewCount).insertComma
        cell.starLabel.text = String(detailRestaurant.favoriteCount).insertComma
        cell.scoreLabel.text = detailRestaurant.score
        cell.addressLabel.text = detailRestaurant.storeAddress
        cell.detailAddressLabel.text = detailRestaurant.storeLandAddress
        
        let storeDetail = detailRestaurant.storeDetail
        cell.openTimeLabel.text = storeDetail.storeOpenTime
        cell.breakTimeLabel.text = storeDetail.storeRestTime
        cell.breakDayLabel.text = storeDetail.storeClose
        cell.priceLabel.text = storeDetail.priceInfo
        
        cell.menu1Label.text = detailRestaurant.storeMenu.menus[0].storeMenuName
        cell.menu1priceLabel.text = String(detailRestaurant.storeMenu.menus[0].price).insertComma
        cell.menu2Label.text = detailRestaurant.storeMenu.menus[1].storeMenuName
        cell.menu2priceLabel.text = String(detailRestaurant.storeMenu.menus[1].price).insertComma
        
        cell.menuPhotos = detailRestaurant.storeMenu.menuphotos
        cell.storePhotos = detailRestaurant.storePhotos
      }
    
      return cell
    }
    else if indexPath.section == 1{
      guard let cell = detailRestaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondRestaurantDetailCell", for: indexPath) as? SecondRestaurantDetailCell else {
        return UICollectionViewCell() }
      if let storeReviews = detailRestaurant?.storeReview,
         let storeEvaluation = detailRestaurant?.storeEvaluation {
        cell.storeReviews = storeReviews
        cell.reviewCountLabel.text = "(\(String(storeEvaluation.evaluationCount)))"
        cell.goodCountLabel.text = "맛있다! (\(String(storeEvaluation.veryGoodCount)))"
        cell.sosoCountLabel.text = "괜찮다 (\(String(storeEvaluation.goodCount)))"
        cell.badCountLabel.text = "별로 (\(String(storeEvaluation.badCount)))"

      }
      
      return cell
    }
    else {
      guard let cell = detailRestaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "ThirdRestaurantDetailCell", for: indexPath) as? ThirdRestaurantDetailCell else {
        return UICollectionViewCell() }
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.size.width, height: 1320)
    }
    else if indexPath.section == 1 {
      return CGSize(width: collectionView.frame.size.width, height: 615)
    }
    else {
      return CGSize(width: collectionView.frame.size.width, height: 1400)
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
  }
  
  
}
