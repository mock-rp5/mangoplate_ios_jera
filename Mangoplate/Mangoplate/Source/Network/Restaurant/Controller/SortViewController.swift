//
//  SortViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class SortViewController: BaseViewController {

  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet var buttons: [UIButton]!
  static var index = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
    for button in buttons {
      button.layer.borderWidth = 1
      button.layer.cornerRadius = 13
      button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
   
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    for button in buttons {
      if buttons[SortViewController.index] == button {
        button.tintColor = .mainOrange
        button.layer.borderColor = UIColor.mainOrange.cgColor
      } else {
        button.tintColor = .mainLightGray
        button.layer.borderColor = UIColor.clear.cgColor
      }
    }
    
  }
  
  @objc func dismissButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: false, completion: nil)
    BaseTabBarController.showTabBar()
  }
  
  @objc func sortButtonTapped(_ sender: UIButton) {
    guard let index = buttons.firstIndex(of: sender) else { return }
    for button in buttons {
      if buttons[index] == button {
        button.tintColor = .mainOrange
        button.layer.borderColor = UIColor.mainOrange.cgColor
      } else {
        button.tintColor = .mainLightGray
        button.layer.borderColor = UIColor.clear.cgColor
      }
    }
    BaseTabBarController.showTabBar()
   presentAlert(title: "아직 개발중이에요!")
    self.dismiss(animated: false, completion: nil)
    
    
  }

}
