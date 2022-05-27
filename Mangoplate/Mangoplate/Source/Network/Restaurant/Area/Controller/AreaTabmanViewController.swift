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
  var areas = ["서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주", "대전", "광주"]
  

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabMan()
  }

  func setupTabMan() {
    let firstVC = DetailAreaViewController()
    viewControllers.append(firstVC)
    self.dataSource = self

    let bar = TMBar.ButtonBar()
    bar.backgroundView.style = .blur(style: .light)
    
    bar.buttons.customize { button in
      button.tintColor = .lightGray
      button.selectedTintColor = .mainOrange
      button.font = .systemFont(ofSize: 15, weight: .medium)
      button.selectedFont = .systemFont(ofSize: 15, weight: .medium)
    }
    
    bar.indicator.weight = .custom(value: 2)
    bar.indicator.tintColor = .mainOrange

    addBar(bar, dataSource: self, at: .top)
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
