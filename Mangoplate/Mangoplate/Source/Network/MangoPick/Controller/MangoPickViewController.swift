//
//  MangoPickViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit
import Pageboy
import Tabman

class MangoPickViewController: TabmanViewController {

  // MARK: Properties
  var viewControllers: [UIViewController] = []
  var titles: [String] = ["EAT딜", "스토리", "Top리스트"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.isHidden = true
    
    let firstVC = EATDealViewController()
    let secondVC = StoryViewController()
    let thirdVC = TopListViewController()
    
    viewControllers.append(firstVC)
    viewControllers.append(secondVC)
    viewControllers.append(thirdVC)
    
    self.dataSource = self
    
    let bar = TMBar.ButtonBar()
    
    bar.backgroundView.style = .blur(style: .light) // 탭 배경 투명처리
    bar.layout.contentMode = .fit // 화면 꽉 차게 탭 구성
    
    bar.buttons.customize { button in
      button.tintColor = .lightGray
      button.selectedTintColor = .mainOrange
      button.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    bar.indicator.weight = .custom(value: 2)
    bar.indicator.tintColor = .mainOrange
    
    addBar(bar, dataSource: self, at: .top)
  }
}

extension MangoPickViewController: PageboyViewControllerDataSource, TMBarDataSource {
  func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return viewControllers.count
  }
  
  func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
    return viewControllers[index]
  }
  
  func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    nil
  }
  
  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
    let item = TMBarItem(title: titles[index])
    return item
  }
  
  
}
