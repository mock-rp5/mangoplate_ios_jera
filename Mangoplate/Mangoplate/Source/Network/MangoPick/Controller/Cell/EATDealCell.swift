//
//  EATDealCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class EATDealCell: UITableViewCell {

  @IBOutlet weak var foodImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var salePriceLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var menuLabel: UILabel!
  @IBOutlet weak var dicountLabel: UILabel!
  @IBOutlet weak var newView: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    priceLabel.text = setPriceText(price: "17000")
    priceLabel.attributedText = priceLabel.text?.strikeThrough()
    salePriceLabel.text = setPriceText(price: "15000")
  }
  
  override func prepareForReuse() {
    foodImageView.image = nil
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setPriceText(price: String) -> String {
    return "₩\(price.insertComma)"
  }
    
}
