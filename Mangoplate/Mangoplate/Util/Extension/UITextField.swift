//
//  UITextField.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//
import UIKit

extension UITextField {
  func addBottomBorderWithColor(color: UIColor, spacing: CGFloat = 10, height: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(
      x: 0,
      y: self.frame.size.height - height + spacing,
      width: self.frame.size.width - 40,
      height: height
    )
    self.layer.addSublayer(border)
  }
}
