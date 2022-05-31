//
//  LogoutMyPageViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class LogoutMyPageViewController: BaseViewController {

  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    loginButton.layer.cornerRadius = 22
    super.viewDidLoad()
    loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
  }
  
  @objc func loginButtonTapped(_ sender: UIButton) {
    let vc = UINavigationController(rootViewController: SignInHomeViewController())
    vc.modalTransitionStyle = .crossDissolve
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }

}
