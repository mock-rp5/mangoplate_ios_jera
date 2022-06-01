//
//  DeleteReviewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import UIKit

class DeleteReviewController: UIViewController {

  @IBOutlet weak var updateButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var backgroundButton: UIButton!
  var postId: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateButton.layer.borderWidth = 1
    updateButton.layer.borderColor = UIColor.mainOrange.cgColor
    updateButton.layer.cornerRadius = 18
    updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    
    deleteButton.layer.borderWidth = 1
    deleteButton.layer.borderColor = UIColor.mainOrange.cgColor
    deleteButton.layer.cornerRadius = 18
    deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    
    cancelButton.layer.borderWidth = 1
    cancelButton.layer.borderColor = UIColor.darkGray.cgColor
    cancelButton.layer.cornerRadius = 18
    cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    backgroundButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
      
  }
  
  @objc func cancelButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func updateButtonTapped(_ sender: UIButton) {
    self.presentAlert(title: "아직 개발중이에요!")
  }
  
  @objc func deleteButtonTapped(_ sender: UIButton) {
    guard let postId = postId else { return }
    MyPageDataManager().deleteMyReview(postId: postId, viewController: self)
  }
}

extension DeleteReviewController {
  func successDeleteReview() {
    print("successDeleteReview")
    self.presentAlert(title: "리뷰가 삭제되었습니다.")
    // 리뷰 삭제하고 팝업뷰 사라지는 순간에 리뷰 reload알림 보냄
    NotificationCenter.default.post(name: .reviewReload, object: nil)
    self.dismiss(animated: true, completion: nil)
  }
  
  func failedDeleteReview(message: String) {
    print("failedDeleteReview")
    self.presentAlert(title: message)
  }
}
