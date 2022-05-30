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
  var latitude: Float?
  var longtitude: Float?
  var locationServicesEnabled = false
  
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
    getLocation()
    
    // 첫 화면은 강남 지역만 가져와서 보여줌
    showIndicator()
    if locationServicesEnabled {
      let restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: "1", detailarea: nil, x: latitude, y: longtitude)
      RestaurantDataManager().getRestaurant(parameters: restuarantRequest, viewController: self)
    } else {
      let restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: "1", detailarea: nil, x: nil, y: nil)
      RestaurantDataManager().getRestaurant(parameters: restuarantRequest, viewController: self)
    }
    
    // 지역 선택 시, 선택한 지역과 nvigationTitle 받아올 NotificationCenter 등록
    NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAreasString), name: .selectAreaString, object: nil)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   // RestaurantDataManager().getAreas(viewController: self)
    setNavigationTitle(title: "", color: .black)
  }
  
  private func setLocation() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    if CLLocationManager.locationServicesEnabled() {
      print("위치서비스 on상태")
      locationServicesEnabled = true
      locationManager.startUpdatingLocation()
    } else {
      locationServicesEnabled = false
      print("위치서비스 off상태")
    }
  }
  
  private func getLocation() {
    let coor = locationManager.location?.coordinate
    latitude = Float(coor?.latitude ?? 37.5273165780626)
    longtitude = Float(coor?.longitude ?? 127.03523742986329)
  }
  
  // MARK: - Methods
  private func setNavigationBar() {
    self.navigationController?.navigationBar.isTransparent = true
    self.navigationItem.setLeftsubTitleAndTitle(title: "서울-강남 ∨", subTitle: "지금 보고있는 지역은", target: self, action: #selector(navigationTitleTapped))
    
    let searchButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "magnifyingglass", imageName: nil, tintColor: .darkGray, width: 25, height: 25)
    let mapButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "map", imageName: nil, tintColor: .darkGray, width: 25, height: 25)
    
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
  
  // 선택한 지역과 navigaionTitle 받아옴
  @objc func didRecieveAreasString(_ notication: Notification) {
    let data = notication.object as! String
    let datas = data.split(separator: "|") // |를 기준으로 데이터 자름
    let restuarantRequest: RestaurantRequest
    
    print(datas)
    self.navigationItem.setLeftsubTitleAndTitle(title: String(datas[2]), subTitle: "지금 보고있는 지역은", target: self, action: #selector(navigationTitleTapped))
    
    // 전체지역 선택했으면 상세지역은 보내지 않음
    if datas[1] == "0" {
      // 위치 서비스 동의한 상태면 위치도 같이 보냄
      if locationServicesEnabled {
        restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: String(datas[0]), detailarea: nil, x: latitude, y: longtitude)
      } else {
        restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: String(datas[0]), detailarea: nil, x: nil, y: nil)
      }
    }
    
    // 전체 지역 선택하지 않았으면
    else {
      if locationServicesEnabled {
        restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: String(datas[0]), detailarea: String(datas[1]), x: latitude, y: longtitude)
      } else {
        restuarantRequest = RestaurantRequest(page: nil, pagesize: nil, area: String(datas[0]), detailarea: String(datas[1]), x: nil, y: nil)
      }
    }
    
    // 선택한 지역들 조회
    showIndicator()
    RestaurantDataManager().getRestaurant(parameters: restuarantRequest, viewController: self)
  }
  
  // 정렬 버튼 클릭
  @objc func sortButtonTapped(_ sender: UIButton) {
    let vc = SortViewController()
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    BaseTabBarController.hideTabBar()
    present(vc, animated: true)
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
      cell.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
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
        
        if let distance = restaurants[indexPath.row].distance {
          cell.distanceLabel.text = "\(String(distance))km"
        }
        
        
        // 이미지가 있으면 섬네일 넣음
        if let urlString = restaurants[indexPath.row].thumbnailImgUrl {
          DispatchQueue.main.async {
            cell.restaurantImageView.load(urlString: urlString)
          }
          
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
      return CGSize(width: collectionView.frame.size.width / 2 - 15, height: collectionView.frame.size.width / 2 + 45)
      
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 2 {
      let vc = DetailRestaurantViewController()
      vc.modalPresentationStyle = .fullScreen
      
      if let restaurants = resturants {
        vc.navigationTitle = restaurants[indexPath.row].storeName
      }
     
      BaseTabBarController.hideTabBar()
      self.navigationController?.pushViewController(vc, animated: true)
    }
   
  }
}

// MARK : - API
extension RestaurantViewController {
  
  // 지역 get
  func successGetAreas(areaResults: [AreasResult]) {
    print("successGetAreas")
    SharedAreaResults.shared.areaResults = areaResults
    dismissIndicator()
  }
  
  func failedGetAreas(message: String) {
    print("failedGetAreas")
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
  
  // 식당 get
  func successGetRestaurants(restaurantResult: [RestaurantResult]) {
    print("successGetRestaurants")
    self.resturants = restaurantResult
    collectionView.reloadData()
    dismissIndicator()
  }
}



