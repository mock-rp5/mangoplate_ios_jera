//
//  StarCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import UIKit

class StarCell: UITableViewCell {

  @IBOutlet weak var foodImageView: UIImageView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var storeNameLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var watchingLabel: UILabel!
  @IBOutlet weak var writingLabel: UILabel!
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    foodImageView.layer.cornerRadius = 10
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
