//
//  TasteCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class TasteCell: UICollectionViewCell {

  @IBOutlet weak var goodButton: UIButton!
  @IBOutlet weak var sosoButton: UIButton!
  @IBOutlet weak var badButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    goodButton.layer.borderColor = UIColor.mainOrange.cgColor
    goodButton.layer.borderWidth = 1
    goodButton.layer.cornerRadius = 14
    sosoButton.layer.borderColor = UIColor.mainLightGray.cgColor
    sosoButton.layer.borderWidth = 1
    sosoButton.layer.cornerRadius = 14
    badButton.layer.borderColor = UIColor.mainLightGray.cgColor
    badButton.layer.borderWidth = 1
    badButton.layer.cornerRadius = 14
  }

}
