//
//  AllViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class AllViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var newsCollectionView: UICollectionView!
  var isSelectedTasteButton = [false, false, true] // 별로, 괜찮다, 맛있다 버튼 선택 여부
  var selectedTasteButtonString = "2"
  var feeds: [FeedResult]?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    showIndicator()
    newsCollectionView.register(UINib(nibName: "NewsCell", bundle: .main), forCellWithReuseIdentifier: "NewsCell")
    newsCollectionView.register(UINib(nibName: "TasteCell", bundle: .main), forCellWithReuseIdentifier: "TasteCell")
    newsCollectionView.backgroundColor = .mainLightGray2
    newsCollectionView.delegate = self
    newsCollectionView.dataSource = self
    
    let feedRequest = FeedRequest(evaluation: selectedTasteButtonString, page: nil, pagesize: nil)
    NewsDataManager().getFeed(feedRequest, viewController: self)
    
  }
  
  // MARK: - Methods
  
  // 맛있다, 괜찮다 선택 시 -> 1,2 리턴
  func getSelectedTasteButtonString() -> String{
    selectedTasteButtonString = ""
    for (index, value) in isSelectedTasteButton.enumerated() {
      if value == true {
        selectedTasteButtonString += "\(index),"
      }
    }
    selectedTasteButtonString = selectedTasteButtonString.substring(from: 0,to: selectedTasteButtonString.count - 1) // 맨뒤 , 자름
    return selectedTasteButtonString
  }
}


extension AllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // 평가버튼 셀
    if section == 0 {
      return 1
    }
    
    // 피드 셀
    else {
      if let feeds = feeds {
        return feeds.count
      }
      else {
        return 1
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // 평가버튼 셀
    if indexPath.section == 0 {
      guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "TasteCell", for: indexPath)
              as? TasteCell else { return UICollectionViewCell() }
      cell.delegate = self
      return cell
    }
    
    // 피드 셀
    else {
      guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            as? NewsCell else { return UICollectionViewCell() }
      if let feeds = feeds {
        let feed = feeds[indexPath.row]
        cell.nicknameLabel.text = feed.writer.userName
        cell.writingLabel.text = String(feed.writer.postCount)
        cell.follwerLabel.text = String(feed.writer.follower)
        
        // 프로필 이미지
        if let img = feed.writer.userProfileImg {
          cell.profileImageView.load(urlString: img)
        }
        
        // 평가 이미지
        switch feed.evaluation {
        case 0:
          cell.scoreImageView.image = UIImage(named: "bad")
        case 1:
          cell.scoreImageView.image = UIImage(named: "soso")
        default:
          cell.scoreImageView.image = UIImage(named: "good")
        }
        
        cell.contentLabel.text = feed.feedContent
        cell.goodLabel.text = "좋아요 \(String(feed.likeCount))개"
        cell.commentLabel.text = "댓글 \(String(feed.commentCount))개"
        cell.timeLabel.text = feed.createDate
        cell.photos = feed.photos // 음식 사진 넘겨줌
        cell.imageCollectionView.reloadData()
        
       
      }
     
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
    return CGSize(width: collectionView.frame.width - 20, height: 335)
    }
  }
}

extension AllViewController: TasteButtonEventProtocol {
  
  // 맛있다버튼 클릭
  func goodButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[2] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[2] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let feedRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    NewsDataManager().getFeed(feedRequest, viewController: self)
  }
  
  // 괜찮다 버튼 클릭
  func sosoButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[1] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[1] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let feedRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    NewsDataManager().getFeed(feedRequest, viewController: self)
  }
  
  // 별로 버튼 클릭
  func badButtonClicked(sender: UIButton) {
    if sender.isSelected {
      // 선택되지 않은 상태
      sender.isSelected = false
      isSelectedTasteButton[0] = false
      sender.backgroundColor = .white
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    }
    
    else {
      // 선택된 상태
      sender.isSelected = true
      isSelectedTasteButton[0] = true
      sender.backgroundColor = .mainTasteBackground
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    showIndicator()
    let feedRequest = FeedRequest(evaluation: getSelectedTasteButtonString(), page: nil, pagesize: nil)
    NewsDataManager().getFeed(feedRequest, viewController: self)
  }
}

// MARK: - API
extension AllViewController {
  func successGetFeed(results: [FeedResult]) {
    self.feeds = results
    newsCollectionView.reloadData()
    dismissIndicator()
  }
  
  func failedGetFeed(message: String) {
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
