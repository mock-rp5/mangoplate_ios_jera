//
//  StoryViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class StoryViewController: BaseViewController {

  @IBOutlet weak var storyCollectionView: UICollectionView!
  var stories: [StoryResult]?
  var images: [UIImage]  = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    storyCollectionView.register(UINib(nibName: "StoryCell", bundle: .main), forCellWithReuseIdentifier: "StoryCell")
    storyCollectionView.dataSource = self
    storyCollectionView.delegate = self
    
    showIndicator()
    MangoPickDataManager().getStory(viewController: self)
  }
  
  // 이미지 미리 로드
  private func imagesLoad() {
    if let stories = stories {
      for story in stories {
        images.append(convertURLtoImage(urlString: story.storythumbnailUrl ?? ""))
      }
    }
  }

}

extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let stories = stories {
      return stories.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath)
            as? StoryCell else { return UICollectionViewCell() }
    
    if let stories = stories {
      cell.mainTitleLabel.text = stories[indexPath.row].storyTitle
      cell.subTitleLabel.text = stories[indexPath.row].storySubTitle
      
      // 이미지 넣음
      cell.storyImageView.image = images[indexPath.row]
    }
    
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

// MARK: - API
extension StoryViewController {
  func successGetStory(results: [StoryResult]) {
    self.stories = results
    self.storyCollectionView.reloadData()
    imagesLoad()
    dismissIndicator()
  }
  
  func failedGetStory(message: String) {
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
