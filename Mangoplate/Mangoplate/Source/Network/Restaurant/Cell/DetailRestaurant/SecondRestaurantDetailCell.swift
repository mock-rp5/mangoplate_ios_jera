//
//  SecondRestaurantDetailCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/30.
//

import UIKit

class SecondRestaurantDetailCell: UICollectionViewCell {

  // MARK: - Properties
  @IBOutlet weak var reviewCountLabel: UILabel!
  @IBOutlet weak var goodCountLabel: UILabel!
  @IBOutlet weak var sosoCountLabel: UILabel!
  @IBOutlet weak var badCountLabel: UILabel!
  @IBOutlet weak var feedCollectionView: UICollectionView!
  @IBOutlet weak var blogSearchButton: UIButton!
  var storeReviews: [StoreReview]?
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    blogSearchButton.layer.borderColor = UIColor.mainOrange.cgColor
    blogSearchButton.layer.borderWidth = 1
    blogSearchButton.layer.cornerRadius = 17
    
    feedCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    feedCollectionView.delegate = self
    feedCollectionView.dataSource = self
    feedCollectionView.backgroundColor = .mainLightGray2
    
  }
}


extension SecondRestaurantDetailCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let storeReviews = storeReviews {
      return storeReviews.count
    } else {
      return 3
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UICollectionViewCell() }
    if let storeReviews = storeReviews {
      let storeReview = storeReviews[indexPath.row]
      cell.contentLabel.text = storeReview.feedContent
      
      cell.nicknameLabel.text = storeReview.writer.userName
      cell.writingLabel.text = String(storeReview.writer.reviewCount)
      cell.follwerLabel.text = String(storeReview.writer.follower)
      cell.tagLabel.isHidden = true

      // 프로필 이미지
      if let img = storeReview.writer.userProfileImg {
        cell.profileImageView.load(urlString: img)
      }
      
      // 평가 이미지
      switch storeReview.evaluation {
      case 0:
        cell.scoreImageView.image = UIImage(named: "bad")
      case 1:
        cell.scoreImageView.image = UIImage(named: "soso")
      default:
        cell.scoreImageView.image = UIImage(named: "good")
      }
      
      cell.contentLabel.text = storeReview.feedContent
      cell.goodLabel.text = "좋아요 \(String(storeReview.likeCount))개"
      cell.commentLabel.text = "댓글 \(String(storeReview.commentCount))개"
      cell.timeLabel.text = storeReview.createDate
      cell.photos = storeReview.photos // 음식 사진 넘겨줌
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 20, height: 335)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}


