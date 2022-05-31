//
//  CustomGalleryCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class CustomGalleryCell: UICollectionViewCell {

  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var countView: UIView!
  @IBOutlet weak var imgView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    countView.layer.cornerRadius = 10
    }

}
