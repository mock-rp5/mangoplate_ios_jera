//
//  DetailAreaViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/27.
//

import UIKit

class DetailAreaViewController: UIViewController {

  @IBOutlet weak var applyButton: UIButton!
  @IBOutlet weak var areaCollectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    applyButton.layer.cornerRadius = 15
    areaCollectionView.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
    areaCollectionView.dataSource = self
    areaCollectionView.delegate = self
      
  }
}

extension DetailAreaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = areaCollectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath)
            as? AreaCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: areaCollectionView.frame.width / 2 - 22, height: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  
  
}
