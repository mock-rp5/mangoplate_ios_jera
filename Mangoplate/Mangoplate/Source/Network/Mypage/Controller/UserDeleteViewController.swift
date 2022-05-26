//
//  UserDeleteViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import UIKit

class UserDeleteViewController: BaseViewController {

  @IBOutlet weak var nickNameView: UIView!
  @IBOutlet var checkButtons: [UIButton]!
  @IBOutlet weak var deleteButton: UIButton!
  var checks: [Bool] = [false, false, false, false] // 체크 버튼 상태
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBarBackbuttonTitle(title: "회원탈퇴")
    deleteButton.isEnabled = false
    deleteButton.setEnabledButtonColor()
    deleteButton.layer.cornerRadius = 25
    
    nickNameView.layer.cornerRadius = 10
    
    for button in checkButtons {
      button.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
    }
  }
  
  @objc func checkButtonTapped(_ sender: UIButton) {
    
    guard let index = checkButtons.firstIndex(of: sender) else { return }
    
    if sender.tintColor == .mainOrange {
      sender.tintColor = .lightGray
      checks[index] = false
    } else {
      sender.tintColor = .mainOrange
      checks[index] = true
    }
    
    print(checks)
    
    if checks.allSatisfy({$0 == true}) {
      deleteButton.isEnabled = true
      deleteButton.setEnabledButtonColor()
    }
  }
  

}
