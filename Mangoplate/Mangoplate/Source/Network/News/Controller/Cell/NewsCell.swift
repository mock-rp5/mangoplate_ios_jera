//
//  NewsCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class NewsCell: UICollectionViewCell {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var writingLabel: UILabel!
  @IBOutlet weak var follwerLabel: UILabel!
  @IBOutlet weak var scoreImageView: UIImageView!
  @IBOutlet weak var tagLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var goodLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var imageCollectionView: UICollectionView!
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var pageView: UIView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var dotButton: UIButton!
  @IBOutlet weak var starButton: UIButton!
  
  let images = ["foodImage1", "foodImage2", "foodImage3"]
  var photos: [Photo]?
  var postId: Int? // 현재 cell의 postId
  
  override func awakeFromNib() {
    super.awakeFromNib()
    profileImageView.layer.cornerRadius = 17
    imageCollectionView.register(UINib(nibName: "ImageCell", bundle: .main), forCellWithReuseIdentifier: "ImageCell")
    imageCollectionView.delegate = self
    imageCollectionView.dataSource = self
    pageView.layer.cornerRadius = 8
    
    likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    likeButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    
    dotButton.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
  }
  
  // 좋아요 버튼 클릭 이벤트
  @objc func heartButtonTapped(_ sender: UIButton) {
    NotificationCenter.default.post(name: .reviewHeart, object: postId!)
  }
  
  // 더보기 버튼 클릭 이벤트 -> 리뷰 삭제, 수정 팝업창 보여줌
  @objc func moreButtonTapped(_ sender: UIButton) {
    NotificationCenter.default.post(name: .reviewMore, object: postId!)
  }

}

extension NewsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let photos = photos {
      return photos.count
    } else {
      return images.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
            as? ImageCell else { return UICollectionViewCell() }
    
    if let photos = photos {
      pageLabel.text = "1/\(photos.count)"
      cell.foodImageView.load(urlString: photos[indexPath.row].photoUrl)
    } else {
      pageLabel.text = "1/\(images.count)"
      cell.foodImageView.image = UIImage(named: images[indexPath.row])
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x/scrollView.frame.size.width
    if let photos = photos {
      self.pageLabel.text = "\(Int(page+1))/\(photos.count)"
    } else {
      self.pageLabel.text = "\(Int(page+1))/\(images.count)"
    }
    
  }
}


