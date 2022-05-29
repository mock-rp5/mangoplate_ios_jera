//
//  HolicViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class HolicViewController: UIViewController {

  @IBOutlet weak var newsCollectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    newsCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    newsCollectionView.register(UINib(nibName: "TasteCell", bundle: .main), forCellWithReuseIdentifier: "TasteCell")
    newsCollectionView.backgroundColor = .mainLightGray2
    newsCollectionView.delegate = self
    newsCollectionView.dataSource = self
  }
}


extension HolicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
    return 5
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "TasteCell", for: indexPath)
              as? TasteCell else { return UICollectionViewCell() }
      return cell
    } else {
    guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            as? NewsCell else { return UICollectionViewCell() }
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
    return CGSize(width: collectionView.frame.width - 20, height: 430)
    }
  }
}
