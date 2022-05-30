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
      return cell
    }
    
    else if collectionView == storyCollectionView {
      guard let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell else { return UICollectionViewCell() }
      return cell
    }
    
    else {
      guard let cell = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as? RestaurantCell else { return UICollectionViewCell() }
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
