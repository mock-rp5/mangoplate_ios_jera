//
//  NewsViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit
import Tabman
import Pageboy

class NewsViewController: TabmanViewController {

  // MARK: - Properties
  var viewControllers: [UIViewController] = []
  var titles: [String] = ["전체", "팔로잉", "홀릭"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isTransparent = true
    //self.navigationController?.navigationBar.tintColor = .white
    self.navigationItem.setLeftsubTitleAndTitle(title: "전체지역∨", subTitle: "지금 보고있는 지역은", target: self, action: #selector(navigationTitleTapped))
    
    let firstVC = AllViewController()
    let secondVC = FollowingViewController()
    let thirdVC = HolicViewController()
    
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
      button.font = UIFont.systemFont(ofSize: 15, weight: .regular)
      button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    bar.indicator.weight = .custom(value: 2)
    bar.indicator.tintColor = .mainOrange
    
    addBar(bar, dataSource: self, at: .top)
  }
  
  @objc func navigationTitleTapped(_ sender: UIButton) {
    let vc = AreasViewController()
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    BaseTabBarController.hideTabBar()
    self.present(vc, animated: true)
  }
}

extension NewsViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
