//
//  MyReviewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import UIKit

class MyReviewController: BaseViewController {
  
  // MARK: - Properties
  @IBOutlet weak var reviewCollectionView: UICollectionView!
  var reviews: [FeedResult]?
  var isSelectedTasteButton = [true, true, true] // 별로, 괜찮다, 맛있다 버튼 선택 여부
  var selectedTasteButtonString = "0,1,2"
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setNavigationBarBackbuttonTitle(title: "타임라인")
    self.setNavigationTintColor(color: .mainOrange)
    
    NotificationCenter.default.addObserver(self, selector: #selector(moreButtonTapped), name: .reviewMore, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(reloadReviews), name: .reviewReload, object: nil)
    
    self.navigationController?.navigationBar.isTransparent = true
 
    reviewCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    reviewCollectionView.register(UINib(nibName: "TasteCell", bundle: .main), forCellWithReuseIdentifier: "TasteCell")
    reviewCollectionView.backgroundColor = .mainLightGray2
    reviewCollectionView.delegate = self
    reviewCollectionView.dataSource = self
    
    showIndicator()
    let reviewRequest = FeedRequest(evaluation: selectedTasteButtonString, page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    BaseTabBarController.hideTabBar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    BaseTabBarController.showTabBar()
  }
  
  @objc func moreButtonTapped(_ sender: Notification) {
    let postId = sender.object as! Int
    print("postId = \(postId)")
    let vc = DeleteReviewController()
    vc.modalTransitionStyle = .crossDissolve
    vc.modalPresentationStyle = .overCurrentContext
    vc.postId = postId
    present(vc, animated: true, completion: nil)
  }
  
  @objc func reloadReviews(_ sender: Notification) {
    let reviewRequest = FeedRequest(evaluation: selectedTasteButtonString, page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
  
  // 맛있다, 괜찮다 선택 시 -> 1,2 리턴
  func getSelectedTasteButtonString() -> String{
    selectedTasteButtonString = ""
    for (index, value) in isSelectedTasteButton.enumerated() {
      if value == true {
        selectedTasteButtonString += "\(index),"
      }
    }
    selectedTasteButtonString = selectedTasteButtonString.substring(from: 0,to: selectedTasteButtonString.count - 1) // 맨뒤 , 자름
    return selectedTasteButtonString
  }
  
  @objc func heartButtonTapped(_ sender: UIButton) {
    if sender.isSelected == false {
      sender.tintColor = .mainOrange
      sender.isSelected = true
    }
    else {
      sender.tintColor = .lightGray
      sender.isSelected = false
    }
  }
  
  
}

extension MyReviewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
    // 평가버튼 셀
    if section == 0 {
      return 1
    }
    
    // 피드 셀
    else {
      if let reviews = reviews {
        return reviews.count
      }
      else {
        return 0
      }
    }
   
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // 평가버튼 셀
    if indexPath.section == 0 {
      guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: "TasteCell", for: indexPath)
              as? TasteCell else { return UICollectionViewCell() }
      cell.delegate = self
      return cell
    }
    else {
   
      guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            as? NewsCell else { return UICollectionViewCell() }
      if let reviews = reviews {
        let review = reviews[indexPath.row]
        cell.tagLabel.text = "@\(review.storeName)"
        cell.nicknameLabel.text = review.writer.userName
        cell.writingLabel.text = String(review.writer.reviewCount)
        cell.follwerLabel.text = String(review.writer.follower)
        cell.postId = review.postId

        // 프로필 이미지
        if let img = review.writer.userProfileImg {
          cell.profileImageView.load(urlString: img)
        }

        // 평가 이미지
        switch review.evaluation {
        case 0:
          cell.scoreImageView.image = UIImage(named: "bad")
        case 1:
          cell.scoreImageView.image = UIImage(named: "soso")
        default:
          cell.scoreImageView.image = UIImage(named: "good")
        }

        cell.contentLabel.text = review.feedContent
        cell.goodLabel.text = "좋아요 \(String(review.likeCount))개"
        cell.commentLabel.text = "댓글 \(String(review.commentCount))개"
        cell.timeLabel.text = review.createDate
        cell.photos = review.photos // 음식 사진 넘겨줌
        cell.imageCollectionView.reloadData()
      }
     
      return cell
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.width, height: 30)
    } else {
    return CGSize(width: collectionView.frame.width - 20, height: 335)
    }
    
  }
}


extension MyReviewController: TasteButtonEventProtocol {
  
  // 맛있다버튼 클릭
  func goodButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[2] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[2] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let reviewRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
  
  // 괜찮다 버튼 클릭
  func sosoButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[1] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[1] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let reviewRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
  
  // 별로 버튼 클릭
  func badButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[0] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[0] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let reviewRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
}



// MARK: API
extension MyReviewController {
  func successGetMyReview(results: [FeedResult]) {
    self.reviews = results
    print(reviews)
    reviewCollectionView.reloadData()
    dismissIndicator()
  }
  
  func failedGetMyReview(message: String) {
    self.presentAlert(title: message)
    dismissIndicator()
  }
}
