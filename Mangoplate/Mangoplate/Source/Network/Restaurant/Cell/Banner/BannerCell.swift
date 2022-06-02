//
//  BannerCell.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit
import SnapKit

// 배너셀 안에 컬렉션뷰 구현, 자동 스크롤 규현
class BannerCell: UICollectionViewCell {
  
  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  //let bannerImageName = ["banner1", "banner2", "banner3", "banner4", "banner5"]
  var banners: [BannerResult]?
  var nowPageIndex = 0 // 현재 페이지 index
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(UINib(nibName: "BannerSubCell", bundle: .main), forCellWithReuseIdentifier: "bannerSubCell")
    
    bannerTimer()
    RestaurantDataManager().getBanner(cell: self)
  }
  
  // MARK: - Methods
  // 5초마다 실행되는 타이머
  func bannerTimer() {
    let _: Timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
      self.bannerMove()
    }
  }
  
  func bannerMove() {
    // 현재 페이지가 마지막 페이지라면 처음 페이지로 돌아감
    guard let banners = banners else {
      return
    }

    if nowPageIndex == banners.count - 1 {
      collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
      nowPageIndex = 0
      pageControl.currentPage = nowPageIndex
    } else {
      nowPageIndex += 1
      collectionView.scrollToItem(at: NSIndexPath(item: nowPageIndex, section: 0) as IndexPath, at: .right, animated: true)
      pageControl.currentPage = nowPageIndex
    }
  }
}

// MARK: - UICollectionView
extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let banners = banners else { return 0 }
    return banners.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerSubCell", for: indexPath)
            as? BannerSubCell else { return UICollectionViewCell() }
    guard let banners = banners else { return UICollectionViewCell() }
    cell.bannerImageView.load(urlString: banners[indexPath.row].adBannerImgUrl)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.size.width, height: 170)
  }
  
  // 컬렉션뷰 감속 끝났을 때, 현재 페이지 체크
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    nowPageIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    pageControl.currentPage = nowPageIndex
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    nowPageIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    pageControl.currentPage = nowPageIndex
  }
  
}

// MARK: API
extension BannerCell {
  func successGetBanner(results: [BannerResult]) {
    self.banners = results
    collectionView.reloadData()
    
    if let banners = banners {
      pageControl.numberOfPages = banners.count
    }
    print("successGetBanner")
  }
  
  func failedGetBanner(message: String) {
    print("failedGetBanner \(message)")
  }
}
