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
    
    if let navigationTitle = navigationTitle {
      self.navigationController?.navigationBar.tintColor = .mainOrange
      setNavigationBarBackbuttonTitle(title: navigationTitle)
    }
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
      return cell
    }
    else if indexPath.section == 1{
      guard let cell = detailRestaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondRestaurantDetailCell", for: indexPath) as? SecondRestaurantDetailCell else {
        return UICollectionViewCell() }
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
      return CGSize(width: collectionView.frame.size.width, height: 1300)
    }
    else {
      return CGSize(width: collectionView.frame.size.width, height: 1400)
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
  }
  
  
}
