//
//  UICollectionViewCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import Foundation
import UIKit

extension UICollectionViewCell {
  
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
  
  func convertURLtoImage(urlString: String) -> UIImage {
    let url = URL(string: urlString)
    if let data = try? Data(contentsOf: url!) {
      let image = UIImage(data: data)
      return image!
    }
    return UIImage(named: "noImage")!
  }
}
