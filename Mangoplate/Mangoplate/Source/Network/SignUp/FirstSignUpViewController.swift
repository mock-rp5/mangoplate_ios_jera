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
  @IBOutlet weak var rePasswordTextField: UITextField!
  @IBOutlet weak var emailButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var emailCheckLabel: UILabel!
  @IBOutlet weak var passwordValidCheckLabel: UILabel!
  @IBOutlet weak var passwordSameCheckLabel: UILabel!
  
  var checkEmailDup: Bool = false // 이메일 중복 여부
  
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
  
  // MARK: - Methods
  private func setUI() {
    setNavigationBarBackbuttonTitle(title: "이메일로 가입")
    
    emailTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 40)
    emailTextField.addTarget(self, action: #selector(emailEditingChanged), for: .editingChanged)
    
    passwordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 40)
    passwordTextField.addTarget(self, action: #selector(textFieldEditingChaged), for: .editingChanged)
    
    rePasswordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 40)
    rePasswordTextField.addTarget(self, action: #selector(textFieldEditingChaged), for: .editingChanged)
    
    emailButton.layer.cornerRadius = 25
    emailButton.isEnabled = false
    emailButton.setEnabledButtonColor()
    emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
    
    nextButton.isEnabled = false
    nextButton.setEnabledButtonColor()
    nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    
    emailCheckLabel.text = ""
    passwordSameCheckLabel.text = ""
    passwordValidCheckLabel.text = ""
    
    let cancelButton = self.navigationItem.setNavigationItemButton(self, action: #selector(xButtonTapped(_:)), symbolName: nil, imageName: "xButton", tintColor: .darkGray, width: 25, height: 25)
    self.navigationItem.rightBarButtonItem = cancelButton
  }
  
  // 최소 6~12자 영문, 숫자 포함하는 체크하는 정규 표현식
  private func validPassword(password: String) -> Bool {
    let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{6,12}")
    let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
    return passwordtesting.evaluate(with: password)
  }
  
  // 비밀번호가 같은지 체크
  private func samePassword() -> Bool {
    if passwordTextField.text == rePasswordTextField.text {
      return true
    } else {
      return false
    }
  }
  
  // MARK: - Actions
  @objc func emailEditingChanged(_ sender: UITextField) {
    if sender.text?.isExists == true {
      emailButton.isEnabled = true
      emailButton.setEnabledButtonColor()
    }
  }
  
  @objc func textFieldEditingChaged(_ sender: UITextField) {
    passwordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 5)
    passwordSameCheckLabel.text = ""
    
    rePasswordTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 5)
    passwordValidCheckLabel.text = ""
    
    // 비밀번호를 두 번 다 입력했으면 다음버튼 활성화
    if rePasswordTextField.text?.isExists == true,
        passwordTextField.text?.isExists == true {
      nextButton.isEnabled = true
      nextButton.setEnabledButtonColor()
    } else {
      nextButton.isEnabled = false
      nextButton.setEnabledButtonColor()
    }
  }
  
  @objc func emailButtonTapped(_ sender: UIButton) {
    emailTextField.addBottomBorderWithColor(color: .mainLightGray, height: 1, width: 5)
    emailCheckLabel.text = ""
    
    guard let email = emailTextField.text else { return }
    let emailCheckRequest = EmailCheckRequest(email: email)
    
    // 이메일 중복 체크
    SignUpDataManager().emailCheck(emailCheckRequest, viewController: self)
  }
  
  @objc func nextButtonTapped(_ sender: UIButton) {
    guard let password = passwordTextField.text else { return }
    
    // 이메일 인증을 하지 않은 경우
    if checkEmailDup == false {
      emailTextField.removeAllSubLayers()
      emailTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
      emailCheckLabel.text = "이메일 인증을 해주세요."
    }
    
    // 비밀번호 형식이 틀린 경우
    if validPassword(password: password) == false {
      passwordTextField.removeAllSubLayers()
      passwordTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
      passwordValidCheckLabel.text = "비밀번호를 다시 확인해주세요."
    }
    
    // 비밀번호가 같지 않은 겨우
    if samePassword() == false {
      rePasswordTextField.removeAllSubLayers()
      rePasswordTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
      passwordSameCheckLabel.text = "비밀번호가 일치 하지 않습니다."
    }
    
    // 이메일인증, 비밀번호 형식, 비밀번호 같게 입력한 경우
    if checkEmailDup == true,
       validPassword(password: password) == true,
       samePassword() == true {
      // 이메일, 비밀번호 저장
      User.shared.email = emailTextField.text
      User.shared.password = passwordTextField.text
      
      let vc = SecondSignUpViewController()
      navigationController?.pushViewController(vc, animated: true)
      
    }
  }
  
  @objc func xButtonTapped(_ sender: UIButton) {
    print("xButtonTapped")
    self.navigationController?.popToRootViewController(animated: true)
  }
}


extension FirstSignUpViewController {
  
  func successEmailCheck() {
    print("successEmailCheck")
    checkEmailDup = true // 이메일 중복체크 통과
    presentAlert(title: "이메일이 인증되었습니다.")
  }
  
  func failedEmailCheck(message: String) {
    print("failedEmailCheck")
    checkEmailDup = false // 이메일 중복 발생
    emailTextField.addBottomBorderWithColor(color: .mainOrange, height: 1, width: 5)
    emailCheckLabel.text = message
  }
  
}
