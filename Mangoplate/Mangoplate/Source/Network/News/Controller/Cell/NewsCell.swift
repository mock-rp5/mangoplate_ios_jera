//
//  NewsCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class NewsCell: UICollectionViewCell {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var writingLabel: UILabel!
  @IBOutlet weak var follwerLabel: UILabel!
  @IBOutlet weak var scoreImageView: UIImageView!
  @IBOutlet weak var tagLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var goodLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    profileImageView.layer.cornerRadius = 17
  }

}
