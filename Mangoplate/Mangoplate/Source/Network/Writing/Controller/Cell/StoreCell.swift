//
//  StoreCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class StoreCell: UITableViewCell {

  @IBOutlet weak var storeLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
