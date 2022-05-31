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
  var areas = ["서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주", "대전", "광주", "강원도", "경상남도", "경상북도", "전라남도", "전라북도", "충청남도", "충청북도", "울산", "세종", "일본", "중국", "아시아", "유럽", "미국", "캐나다", "중남미", "오세아니아", "해외기타"]
  var detailAreas = [["전체", "가로수길", "강남역", "강동구", "개포/수서/일원",
                      "관악구", "교대/서초", "구로구", "금천구", "논현동", "대치동", "도곡동", "동작/사당", "등촌/강서", "목동/양천", "방배/반포/잠원", "방이동", "삼성동", "서래마을", "송파/가락", "신사/압구정", "신천/잠실", "양재동", "여의도", "역삼/선릉", "영등포구", "청담동"],
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
    isSelectedCell = [[false, false, false, false, false,
                       false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
                       [false, false, false, false, false, false, false, false],
                     [false, false, false, false, false, false, false, false]]
  }
  
  @objc func applyButtonTapped(_ sender: UIButton) {
    let area = pageIndex // 선택한 전체지역
    var detailArea = "" // 선택한 상세지역
    var navigationTitle = "" // 선택한 지역들을 보여주는 title
    var detailCount = 0 // 선택한 상세지역 개수
    
    for (index, value) in isSelectedCell[pageIndex].enumerated() {
      if value == true { // 선택된 셀이라면
        if detailArea == "" { // navigaionTitle 선택한 상세지역 앞부분만 담음
          navigationTitle = detailAreas[area][index]
        }
        detailCount += 1
        if pageIndex == 0 {
          detailArea += "\(index),"
        } else {
          detailArea += "\(index+26),"
        }
        
      }
    }
    detailArea = detailArea.substring(from: 0,to: detailArea.count - 1) // 맨뒤에 , 자름 (ex) 1,2,3)
    
    // 상세지역 선택에서 전체를 선택했다면 지역만 보냄
    if isSelectedCell[pageIndex][0] {
      navigationTitle = "\(areas[area]) ∨"
      detailArea = "0"
    } else { // 전체 선택 안했다면 navigaionTitle에 "고양시 외 0곳" 같이 붙임
     navigationTitle += " 외 \(String(detailCount-1))곳 ∨"
    }
    
    let selectAreaString = "\(area+1)|\(detailArea)|\(navigationTitle)"
    
    // 선택한 지역들과 navgationTitle NotificationCenter로 보냄
    NotificationCenter.default.post(name: .selectAreaString, object: selectAreaString)
   
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

