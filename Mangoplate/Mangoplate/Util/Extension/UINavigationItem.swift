//
//  UINavigationItem.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit
import SnapKit

extension UINavigationItem {
  
  // 네비게이션바의 오른쪽에 부제목, 제목의 타이틀 달아줌
  func setLeftsubTitleAndTitle(title: String, subTitle: String) {
    let titleText = "\(subTitle)\n\(title)"
    
    let titleButton = UIButton()
    titleButton.titleLabel?.lineBreakMode = .byWordWrapping // 버튼 줄바꿈 활성화
    titleButton.tintColor = .black
    titleButton.imageView?.image = UIImage(systemName: "magnifyingglass")
    
    let subTitleFontSize = UIFont.systemFont(ofSize: 12, weight: .light)
    let titleFontSize = UIFont.systemFont(ofSize: 17, weight: .medium)
    
    let attributedStr = NSMutableAttributedString(string: titleText)
    attributedStr.addAttribute(.font, value: subTitleFontSize, range: (titleText as NSString).range(of: subTitle))
    attributedStr.addAttribute(.font, value: titleFontSize, range: (titleText as NSString).range(of: title))
    
    titleButton.setAttributedTitle(attributedStr, for: .normal)
    self.leftBarButtonItem = UIBarButtonItem.init(customView: titleButton)
  }
  
  // 네비게이션바에 버튼 생성
  func setNavigationItemButton(_ target: Any?, action: Selector?, symbolName: String?, imageName: String?, tintColor: UIColor) -> UIBarButtonItem {
    let button = UIButton(type: .system)
    if let symbolName = symbolName {
      button.setImage(UIImage(systemName: symbolName), for: .normal)
    }
   
    if let imageName = imageName {
      button.setImage(UIImage(named: imageName), for: .normal)
    }
    
    if let action = action {
      print("action")
      button.addTarget(target, action: action, for: .touchUpInside)
    }
    button.tintColor = tintColor
    
    let barButtonItem = UIBarButtonItem(customView: button)
    barButtonItem.customView?.snp.makeConstraints { make in
      make.width.equalTo(25)
      make.height.equalTo(25)
    }
    return barButtonItem
  }
}
