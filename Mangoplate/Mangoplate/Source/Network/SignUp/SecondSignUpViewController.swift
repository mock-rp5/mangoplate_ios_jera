//
//  SecondViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit

class SecondSignUpViewController: BaseViewController {
  
  // MARK: - Propeteis
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var nickNameTextField: UITextField!
  @IBOutlet weak var completeButton: UIButton!
  @IBOutlet weak var profileImageView: UIImageView!
  
  let picker = UIImagePickerController()
  
  // AMRK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    picker.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setNavigationTintColor(color: .white)
    setNavigationTitle(title: "프로필 정보", color: .white)
    setNavigationBarBackbuttonTitle(title: "")
  }
  
  // MARK: - Methods
  private func setUI() {
    profileButton.layer.cornerRadius = 30
    profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    nickNameTextField.addTarget(self, action: #selector(nicknameEditingChaged), for: .editingChanged)
    completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
    profileImageView.layer.cornerRadius = 43
    
  }
  
  // 앨범 열기
  private func openLibrary() {
    picker.sourceType = .photoLibrary
    present(picker, animated: false)
  }
  
  // 사진 찍기
  private func openCamera() {
    if UIImagePickerController .isSourceTypeAvailable(.camera) { // 카메라를 사용할 수 있는 경우에만 (시뮬레이터x)
      picker.sourceType = .camera
      present(picker, animated: false)
    }
  }
  
  // MARK: - Actions
  @objc func nicknameEditingChaged(_ sender: UITextField) {
    if let text = sender.text {
      let textCountString = "\(String(text.count))/20"
      countLabel.text = textCountString
    } else {
      countLabel.text = "0/20"
    }
  }
  
  @objc func profileButtonTapped(_ sender: UIButton) {
    // 사진찍기, 고르기 액션시트 생성
    let alert = UIAlertController(title: "프로필 선택", message: nil, preferredStyle: .actionSheet)
    
    let library = UIAlertAction(title: "사진 고르기", style: .default) { (action) in
      self.openLibrary()
    }
    
    let camera = UIAlertAction(title: "사진 찍기", style: .default) { (action) in
      self.openCamera()
    }
    
    let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(library)
    alert.addAction(camera)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  @objc func completeButtonTapped(_ sender: UIButton) {
    User.shared.nickName = nickNameTextField.text
    
    // 이메일, 비밀번호, 닉네임 다 저장된 경우
    if let email = User.shared.email,
       let password = User.shared.password,
       let nickName = User.shared.nickName {
      
      // 프로필 사진이 있는 경우
      if let profile = User.shared.profile {
        let profileData = profile.jpegData(compressionQuality: 0.1) // UIImage -> Data
        let signUpRequest = SignUpRequest(email: email, password: password, nickName: nickName, profileImg: profileData)
        SignUpDataManager().signUp(signUpRequest, viewController: self)
      }
      // 프로필 사진이 없는 경우
      else {
        let signUpRequest = SignUpRequest(email: email, password: password, nickName: nickName, profileImg: nil)
        SignUpDataManager().signUp(signUpRequest, viewController: self)
      }
      
    }
  }
}

// MARK : - UIImagePickerControllerDelegate
extension SecondSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      User.shared.profile = image
      profileImageView.image = User.shared.profile
    }
    dismiss(animated: true, completion: nil)
                        
                  
  }
}

// MARK: - API
extension SecondSignUpViewController {
  func successSignUp(result: Result) {
    print("SignUpSuccess")
    print(result.userId)
    self.navigationController?.popToRootViewController(animated: false)
    let vc = BaseTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
  }
  
  func failedSignUp(message: String) {
    print("failedSignUp")
    print(message)
  }
}
