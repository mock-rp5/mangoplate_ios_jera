//
//  AreaCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/27.
//

import UIKit

class AreaCell: UICollectionViewCell {

  @IBOutlet weak var areaButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    areaButton.layer.borderColor = UIColor.mainLightGray.cgColor
    areaButton.layer.borderWidth = 2
    areaButton.layer.cornerRadius = 25
    areaButton.tintColor = .lightGray
  }
  
  override func prepareForReuse() {
    areaButton.setTitle("상세지역", for: .normal)
    areaButton.tintColor = .lightGray
    areaButton.layer.borderColor = UIColor.mainLightGray.cgColor
  }

}
