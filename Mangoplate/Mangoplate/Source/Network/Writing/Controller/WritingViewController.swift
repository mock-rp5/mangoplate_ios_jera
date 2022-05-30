//
//  WritingViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit

class WritingViewController: BaseViewController {
  
  let transition = CircularTransition()

  @IBOutlet weak var eatDealButton: UIButton!
  @IBOutlet weak var beenButton: UIButton!
  @IBOutlet weak var reviewButton: UIButton!
  @IBOutlet weak var storeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
   
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitle(title: "", color: .mainOrange)
  }
  
  // 버튼 페이드인 애니메이션
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.05, animations: ({
      self.eatDealButton.alpha = 1
    }))
    
    UIView.animate(withDuration: 0.3, animations: ({
      self.beenButton.alpha = 1
    }))
    
    UIView.animate(withDuration: 0.5, animations: ({
      self.reviewButton.alpha = 1
    }))
    
    UIView.animate(withDuration: 0.7, animations: ({
      self.storeButton.alpha = 1
    }))
   
  }
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func reviewButtonTapped(_ sender: UIButton) {
    let vc = ReviewWritingViewController()
    vc.modalPresentationStyle = .fullScreen
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
