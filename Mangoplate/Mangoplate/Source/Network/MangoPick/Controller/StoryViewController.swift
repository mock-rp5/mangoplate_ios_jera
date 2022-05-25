//
//  StoryViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class StoryViewController: UIViewController {

  @IBOutlet weak var storyCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    storyCollectionView.register(UINib(nibName: "StoryCell", bundle: .main), forCellWithReuseIdentifier: "StoryCell")
    storyCollectionView.dataSource = self
    storyCollectionView.delegate = self
  }
}

extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath)
            as? StoryCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = storyCollectionView.frame.size.width/2 - 4.5
    return CGSize(width: width, height: width)
  }
  
}
