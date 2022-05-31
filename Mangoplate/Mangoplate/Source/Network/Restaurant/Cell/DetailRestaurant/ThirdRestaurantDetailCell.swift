//
//  ThirdRestaurantDetailCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/30.
//

import UIKit

class ThirdRestaurantDetailCell: UICollectionViewCell {

  @IBOutlet weak var topListCollectionView: UICollectionView!
  @IBOutlet weak var storyCollectionView: UICollectionView!
  @IBOutlet weak var restaurantCollectionView: UICollectionView!
  
  var restaurants: [RestaurantResult]?
  var topLists: [TopListResult]?
  var stories: [StoryResult]?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    topListCollectionView.register(UINib(nibName: "TopListCell", bundle: .main), forCellWithReuseIdentifier: "TopListCell")
    topListCollectionView.delegate = self
    topListCollectionView.dataSource = self
    topListCollectionView.backgroundColor = .mainLightGray2
    
    storyCollectionView.register(UINib(nibName: "StoryCell", bundle: .main), forCellWithReuseIdentifier: "StoryCell")
    storyCollectionView.delegate = self
    storyCollectionView.dataSource = self
    
    restaurantCollectionView.register(UINib(nibName: "RestaurantCell", bundle: .main), forCellWithReuseIdentifier: "restaurantCell")
    restaurantCollectionView.delegate = self
    restaurantCollectionView.dataSource = self
    
    let restaurantRequest = RestaurantRequest(page: nil, pagesize: 4, area: "1", detailarea: nil, x: nil, y: nil)
    RestaurantDataManager().getRestaurant(parameters: restaurantRequest, viewController: self)
    
    let topListRequest = TopListRequest(page: nil, pagesize: 3)
    MangoPickDataManager().getTopList(topListRequest, viewController: self)
    
    let storyRequest = StoryRequest(page: nil, pagesize: 2)
    MangoPickDataManager().getStory(storyRequest, viewController: self)
  }
}


extension ThirdRestaurantDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == topListCollectionView {
      return 3
    }
    
    else if collectionView == storyCollectionView {
      return 2
    }
    
    else {
      return 4
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == topListCollectionView {
      guard let cell = topListCollectionView.dequeueReusableCell(withReuseIdentifier: "TopListCell", for: indexPath) as? TopListCell else { return UICollectionViewCell() }
      
      if let topLists = topLists {
        cell.subTitleLabel.text = topLists[indexPath.row].topListSubTitle
        cell.mainTitleLabel.text = topLists[indexPath.row].topListTitle
        cell.watchingLabel.text = String(topLists[indexPath.row].viewCount).insertComma
        cell.timeLabel.text = topLists[indexPath.row].createDate
        
        // 이미지가 있으면 섬네일 넣음
        if let urlString = topLists[indexPath.row].topListThumbnailUrl {
          cell.foodImageView.load(urlString: urlString)
        } else {
          cell.foodImageView.image = UIImage(named: "noImage")
        }
      }
      return cell
    }
    
    else if collectionView == storyCollectionView {
      guard let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell else { return UICollectionViewCell() }
      
      if let stories = stories {
        cell.mainTitleLabel.text = stories[indexPath.row].storyTitle
        cell.subTitleLabel.text = stories[indexPath.row].storySubTitle
        
        // 이미지가 있으면 섬네일 넣음
        if let urlString = stories[indexPath.row].storythumbnailUrl {
          cell.storyImageView.load(urlString: urlString)
        } else {
          cell.storyImageView.image = UIImage(named: "noImage")
        }
      }
      return cell
    }
    
    else {
      guard let cell = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as? RestaurantCell else { return UICollectionViewCell() }
      if let restaurants = restaurants {
        let restaurant = restaurants[indexPath.row]
        cell.locationLabel.text = restaurant.areaName
        cell.nameLabel.text = restaurant.storeName
        cell.watchingCountLabel.text = String(restaurant.viewCount).insertComma
        cell.reviewCountLabel.text = String(restaurant.reviewCount).insertComma
        cell.ratingLabel.text = restaurant.score
        
        if let image = restaurant.thumbnailImgUrl {
          cell.restaurantImageView.load(urlString: image)
        }
      }
      
      return cell
    }
   
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == topListCollectionView {
      return CGSize(width: collectionView.frame.width - 20, height: 185)
    }
    
    else if collectionView == storyCollectionView {
      return CGSize(width: collectionView.frame.width / 2 - 15, height: collectionView.frame.width / 2 - 15)
    }
    
    else {
      return CGSize(width: collectionView.frame.width / 2 - 15, height: collectionView.frame.width / 2 - 15 + 60)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if collectionView == topListCollectionView {
      
    }
    
    else if collectionView == storyCollectionView {
      
    }
    
    else {
      
    }
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}


// MARK : - API
extension ThirdRestaurantDetailCell {
  // 식당 get
  func successGetRestaurants(restaurantResult: [RestaurantResult]) {
    print("successGetRestaurants")
    self.restaurants = restaurantResult
    restaurantCollectionView.reloadData()
    dismissIndicator()
  }
  
  
  func failedGetRestaurants(message: String) {
    print("failedGetRestaurants")
    dismissIndicator()
  }
  
  // 식당 get
  func successGetStory(results: [StoryResult]) {
    print("successGetStory")
    self.stories = results
    storyCollectionView.reloadData()
    dismissIndicator()
  }
  
  
  func failedGetStory(message: String) {
    print("failedGetStory")
    dismissIndicator()
  }
  
  // 식당 get
  func successGetTopList(results: [TopListResult]) {
    print("successGetTopList")
    self.topLists = results
    topListCollectionView.reloadData()
    dismissIndicator()
  }
  
  
  func failedGetTopList(message: String) {
    print("failedGetTopList")
    dismissIndicator()
  }
}
