//
//  BaseViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  func setNavigationBarBackbuttonTitle(title: String) {
    self.navigationController?.navigationBar.topItem?.title = title
  }
  
  func setNavigationTintColor(color: UIColor) {
    self.navigationController?.navigationBar.tintColor = color
  }
  
  func setNavigationTitleEmpty() {
    self.navigationItem.title = ""
  }
  
  func setNavigationTitle(title: String, color: UIColor) {
    self.navigationItem.title = title
    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
  }
  
}
