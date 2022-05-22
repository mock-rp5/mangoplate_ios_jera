//
//  SignInHomeViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class SignInHomeViewController: BaseViewController {

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitleEmpty()
  }

  // MARK: - Methods
  @IBAction func emailLoginButtonTapped(_ sender: UIButton) {
    let vc = EmailSignInViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func kakaoLoginTapped(_ sender: UIButton) {
    var checkKakaoAppSucceess: Bool?
    // 카카오톡 설치 여부 확인
    if UserApi.isKakaoTalkLoginAvailable() {
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        if let error = error {
          checkKakaoAppSucceess = false
          print(error)
        } else {
          // 카카오톡 앱으로 로그인 성공
          checkKakaoAppSucceess = true
          print("loginWithKakaoTalk() success.")
          
          _ = oauthToken
        }
      }
    }
    
    // 카카오 앱으로 로그인 실패한 경우만 웹으로 로그인
    if checkKakaoAppSucceess == false {
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let error = error {
          print(error)
        } else {
          // 웹 브라우저 카카오 계정으로 로그인 성공
          print("loginWithKakaoAccount() success.")
        }
      }
    }
  }
  
  @IBAction func jumpButtonTapped(_ sender: Any) {
    let tabBarVC = BaseTabBarController()
    tabBarVC.modalPresentationStyle = .fullScreen
    present(tabBarVC, animated: true)
  }
}
