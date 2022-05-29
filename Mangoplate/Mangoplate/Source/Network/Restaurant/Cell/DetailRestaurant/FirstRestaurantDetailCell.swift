//
//  FirstRestaurantDetailCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class FirstRestaurantDetailCell: UICollectionViewCell {

  @IBOutlet weak var restaurantImageCollectionView: UICollectionView!
  @IBOutlet weak var menuImageCollectionView: UICollectionView!
  @IBOutlet weak var callButton: UIButton!
  @IBOutlet weak var addressView: UILabel!
  let detailFoodImages = ["detailFood1", "detailFood2", "detailFood3"]
  let menuImages = ["menu1", "menu2"]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addressView.layer.borderColor = UIColor.mainLightGray.cgColor
    addressView.layer.borderWidth = 1
    callButton.layer.borderColor = UIColor.lightGray.cgColor
    callButton.layer.borderWidth = 1
    
    restaurantImageCollectionView.register(UINib(nibName: "RestaurantImageCell", bundle: .main), forCellWithReuseIdentifier: "RestaurantImageCell")
    restaurantImageCollectionView.delegate = self
    restaurantImageCollectionView.dataSource = self
    
    menuImageCollectionView.register(UINib(nibName: "RestaurantImageCell", bundle: .main), forCellWithReuseIdentifier: "RestaurantImageCell")
    menuImageCollectionView.delegate = self
    menuImageCollectionView.dataSource = self
      
  }
}


extension FirstRestaurantDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == restaurantImageCollectionView {
      return detailFoodImages.count
    } else {
      return menuImages.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = restaurantImageCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantImageCell", for: indexPath) as? RestaurantImageCell else { return UICollectionViewCell() }
    if collectionView == restaurantImageCollectionView {
      cell.restaurantImageView.image = UIImage(named: detailFoodImages[indexPath.row])
      return cell
    } else {
      cell.restaurantImageView.image = UIImage(named: menuImages[indexPath.row])
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == restaurantImageCollectionView {
      return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    } else {
      return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
  }
  
  
}

