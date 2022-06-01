//
//  MyPageTimelineCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import UIKit

class MyPageTimelineCell: UITableViewCell {

  @IBOutlet weak var reviewLabel: UILabel!
  @IBOutlet weak var reviewButton: UIButton!
  @IBOutlet weak var visitLabel: UILabel!
  @IBOutlet weak var visitButton: UIButton!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
