//
//  TopListViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class TopListViewController: UIViewController {

  @IBOutlet weak var topListCollectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    topListCollectionView.register(UINib(nibName: "TopListCell", bundle: .main), forCellWithReuseIdentifier: "TopListCell")
    topListCollectionView.delegate = self
    topListCollectionView.dataSource = self
  }

}

extension TopListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = topListCollectionView.dequeueReusableCell(withReuseIdentifier: "TopListCell", for: indexPath)
            as? TopListCell else { return UICollectionViewCell() }
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.mainLightGray.cgColor
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
