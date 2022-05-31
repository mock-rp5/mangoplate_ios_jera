//
//  UITableVIewCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//
import UIKit

extension UITableViewCell {
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
}

