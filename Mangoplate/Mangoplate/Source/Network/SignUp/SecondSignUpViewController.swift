//
//  SecondViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit

class SecondSignUpViewController: BaseViewController {

  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setNavigationTintColor(color: .white)
    setNavigationTitle(title: "프로필 정보", color: .white)
    setNavigationBarBackbuttonTitle(title: "")
  }
  
  private func setUI() {
    profileButton.layer.cornerRadius = 30
    textField.addTarget(self, action: #selector(nicknameEditingChaged), for: .editingChanged)
    
  }
  
  @objc func nicknameEditingChaged(_ sender: UITextField) {
    if let text = sender.text {
      let textCountString = "\(String(text.count))/20"
      countLabel.text = textCountString
    } else {
      countLabel.text = "0/20"
    }
    
  }

}
