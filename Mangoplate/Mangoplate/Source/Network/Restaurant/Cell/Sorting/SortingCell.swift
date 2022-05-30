//
//  SortingCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/23.
//

import UIKit

class SortingCell: UICollectionViewCell {

  @IBOutlet weak var locationButton: UIButton!
  @IBOutlet weak var filterButton: UIButton!
  @IBOutlet weak var sortButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    locationButton.layer.cornerRadius = 12
    filterButton.layer.cornerRadius = 12
    filterButton.layer.borderColor = UIColor.darkGray.cgColor
    filterButton.layer.borderWidth = 1
  }

}
