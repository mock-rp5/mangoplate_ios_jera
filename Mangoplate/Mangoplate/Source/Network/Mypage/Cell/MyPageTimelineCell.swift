//
//  MyPageTimelineCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import UIKit

class MyPageTimelineCell: UITableViewCell {

  @IBOutlet weak var reviewLabel: NSLayoutConstraint!
  @IBOutlet weak var reviewButton: UIButton!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
