//
//  EmailSignInViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit

class EmailSignInViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitleEmpty()
    setNavigationTintColor(color: .mainOrange)
  }

  // MARK: - Methods
  private func setUI() {
    setNavigationBarBackbuttonTitle(title: "이메일로 로그인")
    
    loginButton.layer.cornerRadius = 25
    loginButton.isEnabled = false
    loginButton.setEnabledButtonColor()
    
    emailTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 40)
    passwordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 40)
    
    emailTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
  }
  
  @objc func textFieldEditingChanged(_ sender: UITextField) {
    print("textFieldValueChanged")
    if emailTextField.text?.isExists == true, passwordTextField.text?.isExists == true{
      loginButton.isEnabled = true
      loginButton.setEnabledButtonColor()
    } else {
      loginButton.isEnabled = false
      loginButton.setEnabledButtonColor()
    }
  }
  
  @IBAction func signUpButtonTapped(_ sender: UIButton) {
    let vc = FirstSignUpViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
}
