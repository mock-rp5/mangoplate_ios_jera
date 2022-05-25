//
//  TopListCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class TopListCell: UICollectionViewCell {

  @IBOutlet weak var foodImageView: UIImageView!
  @IBOutlet weak var watchingLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var mainTitleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var bookMarkButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    watchingLabel.text = watchingLabel.text?.insertComma
  }

}
