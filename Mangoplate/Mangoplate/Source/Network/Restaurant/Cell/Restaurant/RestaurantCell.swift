//
//  RestaurantCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import UIKit

class RestaurantCell: UICollectionViewCell {

  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var watchingCountLabel: UILabel!
  @IBOutlet weak var reviewCountLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var starButton: UIButton!
  var storeId: Int?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    watchingCountLabel.text = watchingCountLabel.text?.insertComma
    starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
  }
  
  override func prepareForReuse() {
    locationLabel.text = "위치"
    ratingLabel.text = "5.0"
    watchingCountLabel.text = "0"
    reviewCountLabel.text = "0"
    restaurantImageView.image = nil
    distanceLabel.text = ""
  }
  
  // 좋아요 버튼 클릭 이벤트
  @objc func starButtonTapped(_ sender: UIButton) {
    guard let storeId = storeId else {
      return
    }
    NotificationCenter.default.post(name: .storeStar, object: storeId)
  }

}
