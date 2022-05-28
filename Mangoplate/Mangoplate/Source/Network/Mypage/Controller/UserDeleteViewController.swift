//
//  UserDeleteViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import UIKit

class UserDeleteViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var nickNameView: UIView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet var checkButtons: [UIButton]!
  @IBOutlet weak var deleteButton: UIButton!
  var checks: [Bool] = [false, false, false, false] // 체크 버튼 상태
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBarBackbuttonTitle(title: "회원탈퇴")
    profileImageView.layer.cornerRadius = 30
    deleteButton.isEnabled = false
    deleteButton.setEnabledButtonColor()
    deleteButton.layer.cornerRadius = 25
    deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    
    nickNameView.layer.cornerRadius = 10
    
    for button in checkButtons {
      button.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    MyPageDataManager().getUser(viewController: self)
  }
  
  // MARK: - Methods
  // 체크 버튼 클릭
  @objc func checkButtonTapped(_ sender: UIButton) {
    guard let index = checkButtons.firstIndex(of: sender) else { return }
    
    if sender.tintColor == .mainOrange {
      sender.tintColor = .lightGray
      checks[index] = false
    } else {
      sender.tintColor = .mainOrange
      checks[index] = true
    }
    
    // 체크 버튼 모두 클릭되면 탈퇴 버튼 활성화
    if checks.allSatisfy({$0 == true}) {
      deleteButton.isEnabled = true
      deleteButton.setEnabledButtonColor()
    } else {
      deleteButton.isEnabled = false
      deleteButton.setEnabledButtonColor()
    }
  }
  
  @objc func deleteButtonTapped(_ sender: UIButton) {
    MyPageDataManager().deleteUser(viewController: self)
  }
}

// MARK: - API
extension UserDeleteViewController {
  // 회원 탈퇴 API
  func successDeleteUser(message: String) {
    UserDefaults.standard.removeObject(forKey: "jwtKey") // 기기에 저장된 키 삭제
    self.presentBottomAlert(message: message)
    self.navigationController?.popToRootViewController(animated: false)
    let rootVC = UINavigationController(rootViewController: SignInHomeViewController())
    rootVC.modalPresentationStyle = .fullScreen
    present(rootVC, animated: true)
  }
  
  func failedDeleteUser(message: String) {
    self.presentBottomAlert(message: message)
  }
  
  // 회원 조회 API
  func successGetUser(user: GetUserResult) {
    self.nicknameLabel.text = user.userName
    
    if let stringUrl = user.userProfileImg {
      self.profileImageView.load(urlString: stringUrl)
    }
  }
  
  func failedGetUser(message: String) {
    self.presentBottomAlert(message: message)
  }
}
