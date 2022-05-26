//
//  AreasViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import UIKit

class AreasViewController: UIViewController {

  @IBOutlet weak var backgroundButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundButton.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
  }
  
  @objc func backgroundButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

}
