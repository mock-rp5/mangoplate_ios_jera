//
//  MyReviewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/01.
//

import UIKit

class MyReviewController: BaseViewController {
  
  // MARK: - Properties
  @IBOutlet weak var goodButton: UIButton!
  @IBOutlet weak var sosoButton: UIButton!
  @IBOutlet weak var badButton: UIButton!
  @IBOutlet weak var reviewCollectionView: UICollectionView!
  var reviews: [FeedResult]?
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setNavigationBarBackbuttonTitle(title: "타임라인")
    self.setNavigationTintColor(color: .mainOrange)
    
    NotificationCenter.default.addObserver(self, selector: #selector(moreButtonTapped), name: .reviewMore, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(reloadReviews), name: .reviewReload, object: nil)
    
    self.navigationController?.navigationBar.isTransparent = true
    goodButton.layer.borderColor = UIColor.mainOrange.cgColor
    goodButton.layer.borderWidth = 1
    goodButton.layer.cornerRadius = 14
    
    sosoButton.layer.borderColor = UIColor.mainOrange.cgColor
    sosoButton.layer.borderWidth = 1
    sosoButton.layer.cornerRadius = 14
    
    badButton.layer.borderColor = UIColor.mainOrange.cgColor
    badButton.layer.borderWidth = 1
    badButton.layer.cornerRadius = 14
    
    reviewCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    reviewCollectionView.backgroundColor = .mainLightGray2
    reviewCollectionView.delegate = self
    reviewCollectionView.dataSource = self
    
    showIndicator()
    let reviewRequest = FeedRequest(evaluation: "0,1,2", page: nil, pagesize: nil)
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
    let reviewRequest = FeedRequest(evaluation: "0,1,2", page: nil, pagesize: nil)
    MyPageDataManager().getMyReview(reviewRequest, viewController: self)
  }
}

extension MyReviewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let reviews = reviews {
      return reviews.count
    }
    else {
      return 0
    }
   
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
    return CGSize(width: collectionView.frame.width - 20, height: 335)
    
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
