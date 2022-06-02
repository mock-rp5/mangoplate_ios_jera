//
//  MyPageMainCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import UIKit

class MyPageMainCell: UITableViewCell {

  @IBOutlet weak var symbolImageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var starCountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    starCountLabel.text = ""
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    }
    
}
