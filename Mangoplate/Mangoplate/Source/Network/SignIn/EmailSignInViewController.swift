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
  @IBOutlet weak var emailCheckLabel: UILabel!
  @IBOutlet weak var passwordCheckLabel: UILabel!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitleEmpty()
    setNavigationTintColor(color: .mainOrange)
    emailCheckLabel.text = ""
    passwordCheckLabel.text = ""
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
  
  // MARK: Actions
  @objc func textFieldEditingChanged(_ sender: UITextField) {
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
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    let signInRequest = SignInRequest(email: email, password: password)
    SignInDataManger().signIn(signInRequest, viewController: self)
  }
}

extension EmailSignInViewController {
  func successSignIn(jwtKey: String, userID: String) {
    emailTextField.removeAllSubLayers()
    emailTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
    
    passwordTextField.removeAllSubLayers()
    passwordTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
    
    emailCheckLabel.text = ""
    passwordCheckLabel.text = ""
    print("login jwtKey = \(jwtKey)")
    UserDefaults.standard.set(jwtKey, forKey: "jwtKey") // jwtKey 기기에 저장
    UserDefaults.standard.set(userID, forKey: "userID") // userID 기기에 저장
    print("UserDefaults jwtKey- \(Constant.HEADERS)")
    print("UserDefaults userID- \(Constant.USER_ID)")
    
    // 위치 동의 뷰로 이동
    let vc = LocationAgreeViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: false)
  }
  
  func failedSignIn(message: String, code: Int) {
    print("failedSignIn")
    print(code)
    // 이메일을 입력하지 않았거나 계정이 없거나 탈퇴한 회원인 경우
    if code == 2011 || code == 3003 || code == 3005{
      emailTextField.removeAllSubLayers()
      emailTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
      emailCheckLabel.text = message
    }
    
    // 비밀번호를 입력하지 않거나 데이터베이스 에러가 발생한 경우
    else if code == 2012 || code == 4000 {
      passwordTextField.removeAllSubLayers()
      passwordTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
      passwordCheckLabel.text = message
    }
  }
}
