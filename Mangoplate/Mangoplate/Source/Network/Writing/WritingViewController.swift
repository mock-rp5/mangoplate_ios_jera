//
//  WritingViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit

class WritingViewController: UIViewController {
  
  let transition = CircularTransition()

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
