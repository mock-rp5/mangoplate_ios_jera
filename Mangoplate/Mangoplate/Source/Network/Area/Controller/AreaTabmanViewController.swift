//
//  AreaTabmanViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/27.
//

import UIKit
import Tabman
import Pageboy

class AreaTabmanViewController: TabmanViewController {
  
  @IBOutlet weak var tabView: UIView!
  var viewControllers: [UIViewController] = []
  var areas = ["서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주", "대전", "광주", "강원도", "경상남도", "경상북도", "전라남도", "전라북도", "충청남도", "충청북도", "울산", "세종", "일본", "중국", "아시아", "유럽", "미국", "캐나다", "중남미", "오세아니아", "해외기타"]

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabMan()
  }
 
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  func setupTabMan() {
    let firstVC = DetailAreaViewController()
    viewControllers.append(firstVC)
    self.dataSource = self

    let bar = TMBar.ButtonBar()
    bar.backgroundView.style = .blur(style: .light)
    bar.layout.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    bar.buttons.customize { button in
      button.tintColor = .lightGray
      button.selectedTintColor = .mainOrange
      button.font = .systemFont(ofSize: 15, weight: .medium)
      button.selectedFont = .systemFont(ofSize: 15, weight: .medium)
      button.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    bar.indicator.weight = .custom(value: 2)
    bar.indicator.tintColor = .mainOrange

    addBar(bar, dataSource: self, at: .top)
  }
  
  // 현재 페이지 index 가져옴
  override func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: TabmanViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
    // 현재 선택된 page의 index 전달
    NotificationCenter.default.post(name: NSNotification.Name.pageIndex, object: index)
  }

}



extension AreaTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
  func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return areas.count
  }

  func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
    return DetailAreaViewController()
  }

  func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    nil
  }

  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
    return TMBarItem(title: areas[index])
  }
}

