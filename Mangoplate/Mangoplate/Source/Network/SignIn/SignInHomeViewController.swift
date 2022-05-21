//
//  SignInHomeViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/21.
//

import UIKit

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
  
    

}
