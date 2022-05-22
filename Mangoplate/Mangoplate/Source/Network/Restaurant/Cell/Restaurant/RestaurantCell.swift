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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    watchingCountLabel.text = watchingCountLabel.text?.insertComma
  }

}
