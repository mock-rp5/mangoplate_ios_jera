//
//  RestaurantViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit

protocol AreaResultProtocol {
  func dataSend(areaResult: [AreasResult])
}

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
    collectionView.register(UINib(nibName: "SortingCell", bundle: .main), forCellWithReuseIdentifier: "sortingCell")
    collectionView.register(UINib(nibName: "RestaurantCell", bundle: .main), forCellWithReuseIdentifier: "restaurantCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   // RestaurantDataManager().getAreas(viewController: self)
    
  }
  
  // MARK: - Methods
  private func setNavigationBar() {
    self.navigationController?.navigationBar.isTransparent = true
    self.navigationItem.setLeftsubTitleAndTitle(title: "전체지역", subTitle: "지금 보고있는 지역은", target: self, action: #selector(navigationTitleTapped))
    
    let searchButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "magnifyingglass", imageName: nil, tintColor: .darkGray)
    let mapButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "map", imageName: nil, tintColor: .darkGray)
    
    self.navigationItem.rightBarButtonItems = [mapButton, searchButton]
  }
  
  @objc func navigationTitleTapped(_ sender: UIButton) {
    let vc = AreasViewController()
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    BaseTabBarController.hideTabBar()
    self.present(vc, animated: true)
  }
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 1
    case 2:
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
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortingCell", for: indexPath)
              as? SortingCell else { return UICollectionViewCell() }
      return cell
      
    case 2:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
              as? RestaurantCell else { return UICollectionViewCell() }
      return cell
      
    default:
      return UICollectionViewCell()
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
      return CGSize(width: collectionView.frame.size.width, height: 170)
      
    case 1:
      return CGSize(width: collectionView.frame.size.width, height: 130)
      
    case 2:
      return CGSize(width: collectionView.frame.size.width / 2 - 15, height: collectionView.frame.size.width / 2 + 80)
      
    default:
      return CGSize(width: 100, height: 100)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 2 {
      return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    } else {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }

}

// MARK : - API
extension RestaurantViewController {
  func successGetAreas(areaResults: [AreasResult]) {
    print("successGetAreas")
    SharedAreaResults.shared.areaResults = areaResults
  }
  
  func failedGetAreas(message: String) {
    print("failedGetAreas")
    self.presentBottomAlert(message: message)
  }
}


