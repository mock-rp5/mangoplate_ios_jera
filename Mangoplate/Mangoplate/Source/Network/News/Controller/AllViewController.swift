//
//  AllViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class AllViewController: UIViewController {

  @IBOutlet weak var newsCollectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()

    newsCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    newsCollectionView.backgroundColor = .mainLightGray2
    newsCollectionView.delegate = self
    newsCollectionView.dataSource = self
  }
}


extension AllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            as? NewsCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 20, height: 380)
  }
}
