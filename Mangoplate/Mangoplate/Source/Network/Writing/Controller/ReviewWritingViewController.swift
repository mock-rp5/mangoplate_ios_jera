//
//  ReviewWritingViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class ReviewWritingViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet var buttons: [UIButton]!
  @IBOutlet var labels: [UILabel]!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var okButton: UIButton!

  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtons()
    self.dismissKeyboardWhenTappedAround()
    textView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitle(title: "리뷰쓰기", color: .mainOrange)
    setNavigationTintColor(color: .mainOrange)
    setNavigationBarBackbuttonTitle(title: "")
  }
  
  // MARK: - Methods
  func setButtons() {
    okButton.layer.cornerRadius = 25
    okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
    
    buttons[0].setImage(UIImage(named: "selectedWritingBad"), for: .selected)
    buttons[1].setImage(UIImage(named: "selectedWritingSoso"), for: .selected)
    buttons[2].setImage(UIImage(named: "selectedWritingGood"), for: .selected)
    buttons[0].setImage(UIImage(named: "writingBad"), for: .normal)
    buttons[1].setImage(UIImage(named: "writingSoso"), for: .normal)
    buttons[2].setImage(UIImage(named: "writingGood"), for: .normal)
    
    // 맛있다 눌러진 상태
    buttons[2].isSelected = true
    labels[2].textColor = .mainOrange
    
    for button in buttons {
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
  }
  
  // 평가버튼 클릭 (1개만 선택)
  @objc func buttonTapped(_ sender: UIButton) {
    // 선택안된 상태에서 클릭했을 때
    if sender.isSelected == false {
      for (index, button) in buttons.enumerated() {
        if button == sender {
          // 선택한 버튼은 주황색으로
          sender.isSelected = true
          labels[index].textColor = .mainOrange
        }
        else {
          // 나머지 버튼은 회색으로
          button.isSelected = false
          labels[index].textColor = .lightGray
        }
      }
    }
  }
  
  // 입력완료 버튼 클릭
  @objc func okButtonTapped(_ sender: UIButton) {
    Review.shared.content = textView.text
    for (index, button) in buttons.enumerated() {
      if button.isSelected {
        Review.shared.evaluation = index
      }
    }
    print("Review 정보 : \(Review.shared.evaluation) \(Review.shared.content) \(Review.shared.images)")
    dismiss(animated: false, completion: nil)
  }
}

// MARK: - UITextViewDelegate
extension ReviewWritingViewController: UITextViewDelegate {
  // textView 글자수 계산
  func textViewDidChange(_ textView: UITextView) {
    okButton.setTitle("입력완료 (\(textView.text.count)/1000)", for: .normal)
  }
}
