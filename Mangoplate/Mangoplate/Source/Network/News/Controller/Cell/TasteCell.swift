//
//  TasteCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

protocol TasteButtonEventProtocol {
  func goodButtonClicked(sender: UIButton)
  func sosoButtonClicked(sender: UIButton)
  func badButtonClicked(sender: UIButton)
}

class TasteCell: UICollectionViewCell {

  @IBOutlet weak var goodButton: UIButton!
  @IBOutlet weak var sosoButton: UIButton!
  @IBOutlet weak var badButton: UIButton!
  var delegate: TasteButtonEventProtocol?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    goodButton.layer.borderColor = UIColor.mainOrange.cgColor
    goodButton.layer.borderWidth = 1
    goodButton.layer.cornerRadius = 14
    sosoButton.layer.borderColor = UIColor.mainLightGray.cgColor
    sosoButton.layer.borderWidth = 1
    sosoButton.layer.cornerRadius = 14
    badButton.layer.borderColor = UIColor.mainLightGray.cgColor
    badButton.layer.borderWidth = 1
    badButton.layer.cornerRadius = 14
    
    goodButton.setImage(UIImage(named: "selectedGoodIcon"), for: .selected)
    goodButton.setImage(UIImage(named: "goodIcon"), for: .normal)
    goodButton.setTitleColor(.mainOrange, for: .selected)
    goodButton.setTitleColor(.lightGray, for: .normal)
    goodButton.isSelected = true // 처음엔 맛있다 버튼만 클릭한 상태
    goodButton.addTarget(self, action: #selector(goodButtonClicked), for: .touchUpInside)
    
    sosoButton.setImage(UIImage(named: "selectedSosoIcon"), for: .selected)
    sosoButton.setImage(UIImage(named: "sosoIcon"), for: .normal)
    sosoButton.setTitleColor(.mainOrange, for: .selected)
    sosoButton.setTitleColor(.lightGray, for: .normal)
    sosoButton.addTarget(self, action: #selector(sosoButtonClicked), for: .touchUpInside)
    
    badButton.setImage(UIImage(named: "selectedBadIcon"), for: .selected)
    badButton.setImage(UIImage(named: "badIcon"), for: .normal)
    badButton.setTitleColor(.mainOrange, for: .selected)
    badButton.setTitleColor(.lightGray, for: .normal)
    badButton.addTarget(self, action: #selector(badButtonClicked), for: .touchUpInside)
    
  }
  
  @objc func goodButtonClicked(_ sender: UIButton) {
    delegate?.goodButtonClicked(sender: sender)
  }
  
  @objc func sosoButtonClicked(_ sender: UIButton) {
    delegate?.sosoButtonClicked(sender: sender)
  }
  
  @objc func badButtonClicked(_ sender: UIButton) {
    delegate?.badButtonClicked(sender: sender)
  }

}
