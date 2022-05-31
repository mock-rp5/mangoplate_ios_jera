//
//  SecondRestaurantDetailCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/30.
//

import UIKit

class SecondRestaurantDetailCell: UICollectionViewCell {

  // MARK: - Properties
  @IBOutlet weak var reviewCountLabel: UILabel!
  @IBOutlet weak var goodCountLabel: UILabel!
  @IBOutlet weak var sosoCountLabel: UILabel!
  @IBOutlet weak var badCountLabel: UILabel!
  @IBOutlet weak var feedCollectionView: UICollectionView!
  @IBOutlet weak var blogSearchButton: UIButton!
  
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    blogSearchButton.layer.borderColor = UIColor.mainOrange.cgColor
    blogSearchButton.layer.borderWidth = 1
    blogSearchButton.layer.cornerRadius = 17
    
    feedCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    feedCollectionView.delegate = self
    feedCollectionView.dataSource = self
    feedCollectionView.backgroundColor = .mainLightGray2
    
  }
}


extension SecondRestaurantDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 20, height: 335)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}


