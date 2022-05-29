//
//  StoryCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class StoryCell: UICollectionViewCell {

  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var mainTitleLabel: UILabel!
  @IBOutlet weak var storyImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    storyImageView.image = nil
  }

}
