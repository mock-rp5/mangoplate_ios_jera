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
//    // 카카오톡 앱으로 로그인
//    if UserApi.isKakaoTalkLoginAvailable() {
//      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
//        if let error = error {
//          print(error)
//        } else {
//          print("loginWithKakaoTalk() success.")
//          _ = oauthToken
//        }
//      }
//    }
    
    // 카카오 웹으로 로그인
    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
      if let error = error {
        print(error)
      } else {
        // 웹 브라우저 카카오 계정으로 로그인 성공
        print("loginWithKakaoAccount() success.")
        
        let kakaoLoginRequest = KakaoLoginRequest(access_token: oauthToken?.accessToken ?? "")
        SignInDataManger().kakaoLogin(kakaoLoginRequest, viewController: self)
      }
    }
  }
  
  @IBAction func jumpButtonTapped(_ sender: Any) {
    let vc = LocationAgreeViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
}

extension SignInHomeViewController {
  func successKakaoLogin() {
    let vc = BaseTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
}
