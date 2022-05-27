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
  var areaResults: [AreasResult] = []
  var pageIndex: Int = 0
  var detailAreas = [["전체", "가로수길", "강남역", "강동구", "개포/수서/일원", "관악구", "교대/서초", "구로구"],
                      ["전체", "건대/군자/광진", "광화문", "노원구", "대학로/혜화", "동대문구", "동부이촌동", "마포/공덕"],
                    ["전체", "가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시"]]
  
  var isSelectedCell = [[false, false, false, false, false, false, false, false],
                             [false, false, false, false, false, false, false, false],
                           [false, false, false, false, false, false, false, false]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyButton.layer.cornerRadius = 15
    applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    
    areaCollectionView.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
    areaCollectionView.dataSource = self
    areaCollectionView.delegate = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(getPageIndex), name: NSNotification.Name.pageIndex, object: nil)
    
//    if let sharedAreaResults = SharedAreaResults.shared.areaResults,
//       let pageIndex = SharedAreaResults.shared.pageIndex {
//      self.areaResults = sharedAreaResults
//      self.pageIndex = pageIndex
//    }
      
  }
  
  // NotificationCenter로 현재 페이지 get하는 메소드
  @objc func getPageIndex(_ notification: Notification) {
    let pageIndex = notification.object as! Int
    self.pageIndex = pageIndex
    areaCollectionView.reloadData()
    // 선택된 셀 모두 초기화
    isSelectedCell = [[false, false, false, false, false, false, false, false],
                               [false, false, false, false, false, false, false, false],
                             [false, false, false, false, false, false, false, false]]
  }
  
  @objc func applyButtonTapped(_ sender: UIButton) {
    var detailArea = ""
    
    for (index, value) in isSelectedCell[pageIndex].enumerated() {
      if value == true { // 선택된 셀이라면
        detailArea += "\(index),"
      }
    }
    detailArea = detailArea.substring(from: 0,to: detailArea.count - 1) // 맨뒤에 , 자름 (ex) 1,2,3)
    
    let areaAndDetailArea = [String(pageIndex), detailArea] // 지역인덱스, 상세지역인덱스 저장
    print(areaAndDetailArea)
    dismiss(animated: true, completion: nil)
    BaseTabBarController.showTabBar()
  }
  
  // 상세지역 cell 클릭 시 호출되는 메소드
  @objc func detailAreaCellTapped(_ sender: UIButton) {
    
    // 클릭 시, tintColor 바꿈
    if sender.tintColor == .mainOrange {
      sender.tintColor = .lightGray
      sender.layer.borderColor = UIColor.mainLightGray.cgColor
    } else {
      sender.tintColor = .mainOrange
      sender.layer.borderColor = UIColor.mainOrange.cgColor
    }
    
    // 현재 클릭한 cell의 indePath
    let contentView = sender.superview
    let cell = contentView?.superview as! UICollectionViewCell
    guard let indexPath = areaCollectionView.indexPath(for: cell) else { return }
    
    // 선택 상태 배열에 저장
    if self.isSelectedCell[pageIndex][indexPath.row] == true {
      self.isSelectedCell[pageIndex][indexPath.row] = false
    } else {
      self.isSelectedCell[pageIndex][indexPath.row] = true
    }
    print(isSelectedCell)
  }
  
}

extension DetailAreaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if pageIndex == 0 || pageIndex == 1 || pageIndex == 2 {
      return detailAreas[pageIndex].count
    } else {
      return 10
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = areaCollectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath)
            as? AreaCell else { return UICollectionViewCell() }
    if pageIndex == 0 || pageIndex == 1 || pageIndex == 2 {
      cell.areaButton.setTitle(detailAreas[pageIndex][indexPath.row], for: .normal)
      cell.areaButton.addTarget(self, action: #selector(detailAreaCellTapped), for: .touchUpInside)
    }
    
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

