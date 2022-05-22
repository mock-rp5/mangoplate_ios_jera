//
//  RestaurantViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit

class RestaurantViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBar()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "BannerCell", bundle: .main), forCellWithReuseIdentifier: "bannerCell")
    collectionView.register(UINib(nibName: "RestaurantCell", bundle: .main), forCellWithReuseIdentifier: "restaurantCell")
    
  }
  
  // MARK: - Methods
  private func setNavigationBar() {
    self.navigationItem.setLeftsubTitleAndTitle(title: "전체지역", subTitle: "지금 보고있는 지역은")
    
    let searchButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "magnifyingglass", tintColor: .darkGray)
    let mapButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "map", tintColor: .darkGray)
    
    self.navigationItem.rightBarButtonItems = [mapButton, searchButton]
  }
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 4
    
    default:
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    switch indexPath.section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)
              as? BannerCell else { return UICollectionViewCell() }
      return cell
      
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
              as? RestaurantCell else { return UICollectionViewCell() }
      return cell
      
    default:
      return UICollectionViewCell()
    
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.size.width, height: 170)
    }
    else if indexPath.section == 1 {
      return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2 + 100)
    } else {
      return CGSize(width: 100, height: 100)
    }
  }
  
}
