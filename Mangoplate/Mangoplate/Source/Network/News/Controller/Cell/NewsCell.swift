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
  let images = ["foodImage1", "foodImage2", "foodImage3"]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    profileImageView.layer.cornerRadius = 17
    imageCollectionView.register(UINib(nibName: "ImageCell", bundle: .main), forCellWithReuseIdentifier: "ImageCell")
    imageCollectionView.delegate = self
    imageCollectionView.dataSource = self
    pageView.layer.cornerRadius = 8
    pageLabel.text = "1/\(images.count)"
    
  }

}

extension NewsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
            as? ImageCell else { return UICollectionViewCell() }
    cell.foodImageView.image = UIImage(named: images[indexPath.row])
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
  
//  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    let page = Int(targetContentOffset.pointee.x / self.frame.width)
//    self.pageLabel.text = "\(page+2)/\(images.count)"
//  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x/scrollView.frame.size.width
    self.pageLabel.text = "\(Int(page+1))/\(images.count)"
  }
  
  
}


