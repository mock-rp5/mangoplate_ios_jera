//
//  MyPageProfileCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/24.
//

import UIKit

class MyPageProfileCell: UITableViewCell {

  // MARK: - Properties
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nickNameLabel: UILabel!
  @IBOutlet weak var followerLabel: UILabel!
  @IBOutlet weak var followingLabel: UILabel!
  @IBOutlet weak var editButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    editButton.layer.borderWidth = 1
    editButton.layer.borderColor = UIColor.mainLightGray.cgColor
    editButton.layer.cornerRadius = 20
    profileImageView.layer.cornerRadius = 30
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
  }
    
}
