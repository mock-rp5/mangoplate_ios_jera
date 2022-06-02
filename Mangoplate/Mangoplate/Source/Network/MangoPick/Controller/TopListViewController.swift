//
//  TopListViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class TopListViewController: BaseViewController {

  @IBOutlet weak var topListCollectionView: UICollectionView!
  var topLists: [TopListResult]?
  var images: [UIImage]  = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topListCollectionView.register(UINib(nibName: "TopListCell", bundle: .main), forCellWithReuseIdentifier: "TopListCell")
    topListCollectionView.delegate = self
    topListCollectionView.dataSource = self
    
    showIndicator()
    MangoPickDataManager().getTopList(viewController: self)
  }
  
  // 이미지 미리 로드
  private func imagesLoad() {
    if let topLists = topLists {
      for topList in topLists {
        images.append(convertURLtoImage(urlString: topList.topListThumbnailUrl ?? ""))
      }
    }
  }

}

extension TopListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let topLists = topLists {
      return topLists.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = topListCollectionView.dequeueReusableCell(withReuseIdentifier: "TopListCell", for: indexPath)
            as? TopListCell else { return UICollectionViewCell() }
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.mainLightGray.cgColor
    
    if let topLists = topLists {
      cell.subTitleLabel.text = topLists[indexPath.row].topListSubTitle
      cell.mainTitleLabel.text = topLists[indexPath.row].topListTitle
      cell.watchingLabel.text = String(topLists[indexPath.row].viewCount).insertComma
      cell.timeLabel.text = topLists[indexPath.row].createDate
      
      // 이미지 넣음
      cell.foodImageView.image = images[indexPath.row]
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
    return CGSize(width: collectionView.frame.width - 20, height: 185)
  }
}

// MARK: - API
extension TopListViewController {
  func successGetTopList(results: [TopListResult]) {
    self.topLists = results
    topListCollectionView.reloadData()
    imagesLoad()
    dismissIndicator()
  }
  
  func failedGetTopList(message: String) {
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
