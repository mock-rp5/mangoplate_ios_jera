//
//  RestaurantViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit
import CoreLocation
import Alamofire

protocol AreaResultProtocol {
  func dataSend(areaResult: [AreasResult])
}

class RestaurantViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  var locationManager = CLLocationManager()
  var resturants: [RestaurantResult]?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigationBar()
    setLocation()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "BannerCell", bundle: .main), forCellWithReuseIdentifier: "bannerCell")
    collectionView.register(UINib(nibName: "SortingCell", bundle: .main), forCellWithReuseIdentifier: "sortingCell")
    collectionView.register(UINib(nibName: "RestaurantCell", bundle: .main), forCellWithReuseIdentifier: "restaurantCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   // RestaurantDataManager().getAreas(viewController: self)
    
    // 강남 지역만 가져와서 보여줌
    let restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: "1", detailarea: nil, x: nil, y: nil)
    RestaurantDataManager().getRestaurant(parameters: restuarantRequest, viewController: self)
    
  }
  
  private func setLocation() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    if CLLocationManager.locationServicesEnabled() {
      print("위치서비스 on상태")
      locationManager.startUpdatingLocation()
    } else {
      print("위치서비스 off상태")
    }
  }
  
  private func getLocation() {
    let coor = locationManager.location?.coordinate
    let latitude = coor?.latitude
    let longtitude = coor?.longitude
    print(latitude, longtitude)
  }
  
  // MARK: - Methods
  private func setNavigationBar() {
    self.navigationController?.navigationBar.isTransparent = true
    self.navigationItem.setLeftsubTitleAndTitle(title: "서울-강남∨", subTitle: "지금 보고있는 지역은", target: self, action: #selector(navigationTitleTapped))
    
    let searchButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "magnifyingglass", imageName: nil, tintColor: .darkGray)
    let mapButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "map", imageName: nil, tintColor: .darkGray)
    
    self.navigationItem.rightBarButtonItems = [mapButton, searchButton]
  }
  
  @objc func navigationTitleTapped(_ sender: UIButton) {
    getLocation() // 현재 위치정보 가져옴
    
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
      if let resturants = resturants {
        return resturants.count
      } else {
        return 4
      }
    
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
      // 맛집 리스트 셀
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
              as? RestaurantCell else { return UICollectionViewCell() }
      if let restaurants = resturants {
        cell.nameLabel.text = restaurants[indexPath.row].storeName
        cell.locationLabel.text = restaurants[indexPath.row].areaName
        cell.ratingLabel.text = restaurants[indexPath.row].score
        cell.reviewCountLabel.text = String(restaurants[indexPath.row].reviewCount)
        cell.watchingCountLabel.text = String(restaurants[indexPath.row].viewCount).insertComma
        
        // 이미지가 있으면 섬네일 넣음
        if let urlString = restaurants[indexPath.row].thumbnailImgUrl {
          cell.restaurantImageView.load(urlString: urlString)
        } else {
          cell.restaurantImageView.image = UIImage(named: "noImage")
        }
        
      }
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
      return CGSize(width: collectionView.frame.size.width / 2 - 15, height: collectionView.frame.size.width / 2 + 40)
      
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
  
  // 지역 get
  func successGetAreas(areaResults: [AreasResult]) {
    print("successGetAreas")
    SharedAreaResults.shared.areaResults = areaResults
  }
  
  func failedGetAreas(message: String) {
    print("failedGetAreas")
    self.presentBottomAlert(message: message)
  }
  
  // 식당 get
  func successGetRestaurants(restaurantResult: [RestaurantResult]) {
    print("successGetRestaurants")
    self.resturants = restaurantResult
    collectionView.reloadData()
  }
}



