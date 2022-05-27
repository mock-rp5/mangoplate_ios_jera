//
//  AreasViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/26.
//

import UIKit


class AreasViewController: BaseViewController {

  @IBOutlet weak var tabmanView: UIView!
  @IBOutlet weak var backgroundButton: UIButton!
  
  var areasReponse: [AreasResult] = []
  @IBOutlet weak var tabView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad - \(areasReponse)")
    backgroundButton.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
    //setupTabMan()
    addContainerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    RestaurantDataManager().getAreas(viewController: self)
    print("viewWillAppear \(areasReponse)")
  }
  
  func addContainerView() {
    let childVC = AreaTabmanViewController()
    self.tabmanView.addSubview(childVC.view)
    self.addChild(childVC)
    childVC.didMove(toParent: self)
  }
  

  
  @objc func backgroundButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK : - API
extension AreasViewController {
  func successGetAreas(areasResult: [AreasResult]) {
    areasReponse = areasResult
  }
}

