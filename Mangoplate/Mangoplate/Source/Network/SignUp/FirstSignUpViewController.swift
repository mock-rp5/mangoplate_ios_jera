//
//  FirstSignUpViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit

class FirstSignUpViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordCheckTextField: UITextField!
  @IBOutlet weak var emailButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  
  var checkEmailAuth: Bool = false
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    dismissKeyboardWhenTappedAround()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTintColor(color: .black)
  }
  
  private func setUI() {
    setNavigationBarBackbuttonTitle(title: "이메일로 가입")
    
    emailTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1)
    emailTextField.addTarget(self, action: #selector(emailEditingChanged), for: .editingChanged)
    
    passwordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1)
    passwordTextField.addTarget(self, action: #selector(textFieldEditingChaged), for: .editingChanged)
    
    passwordCheckTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1)
    passwordCheckTextField.addTarget(self, action: #selector(textFieldEditingChaged), for: .editingChanged)
    
    emailButton.layer.cornerRadius = 25
    emailButton.isEnabled = false
    emailButton.setEnabledButtonColor()
    emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
    
    nextButton.isEnabled = false
    nextButton.setEnabledButtonColor()
    nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
  }
  
  @objc func emailEditingChanged(_ sender: UITextField) {
    if sender.text?.isExists == true {
      emailButton.isEnabled = true
      emailButton.setEnabledButtonColor()
    }
  }
  
  @objc func textFieldEditingChaged(_ sender: UITextField) {
    if checkEmailAuth == true,
        passwordCheckTextField.text?.isExists == true,
        passwordTextField.text?.isExists == true {
      nextButton.isEnabled = true
      nextButton.setEnabledButtonColor()
    } else {
      nextButton.isEnabled = false
      nextButton.setEnabledButtonColor()
    }
  }
  
  @objc func emailButtonTapped(_ sender: UIButton) {
    if checkEmailAuth == false {
      presentAlert(title: "이메일이 전송되었습니다.")
      checkEmailAuth = true
    } else {
      presentAlert(title: "이미 인증되었습니다.")
    }
  }
  
  @objc func nextButtonTapped(_ sender: UIButton) {
    if passwordTextField.text == passwordCheckTextField.text {
      let vc = SecondSignUpViewController()
      navigationController?.pushViewController(vc, animated: true)
    } else {
      presentAlert(title: "비밀번호가 일치하지 않습니다.")
    }
  }


}
