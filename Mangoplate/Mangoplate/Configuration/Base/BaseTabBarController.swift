//
//  BaseTabBarController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class BaseTabBarController: TabmanViewController {
  // MARK: - Properties
  let restaurantVC = RestaurantViewController()
  let mangoPickVC = MangoPickViewController()
  let writingVC = WritingViewController()
  let newsVC = NewsViewController()
  let mypageVC = MypageViewController()
  
  
  static let tabBar = TMBar.TabBar()
  static let lineBar = TMBar.LineBar()
  
  var viewControllers: [UIViewController] = []
  let titles = ["맛집찾기", "망고픽", "", "소식", "내정보"]
  let images = ["tabbar1", "tabbar2", "tabbar3", "tabbar4", "tabbar5"]
  let selectedImages = ["select_tabbar1", "select_tabbar2", "", "select_tabbar4", "select_tabbar5"]
  
  //var plusButton: TMBarItem?
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let firstVC = UINavigationController(rootViewController: restaurantVC)
    let secondVC = UINavigationController(rootViewController: mangoPickVC)
    let thirdVC = UINavigationController(rootViewController: writingVC)
    let fourthVC = UINavigationController(rootViewController: newsVC)
    let fifthVC = UINavigationController(rootViewController: mypageVC)
    
    viewControllers.append(firstVC)
    viewControllers.append(secondVC)
    viewControllers.append(thirdVC)
    viewControllers.append(fourthVC)
    viewControllers.append(fifthVC)
    
    self.dataSource = self
    self.isScrollEnabled = false
    
    // 커스텀 탭바
    BaseTabBarController.tabBar.backgroundView.style = .blur(style: .light)
    BaseTabBarController.tabBar.buttons.customize { button in
      button.tintColor = .mainLightGray
      button.selectedTintColor = .mainOrange
      button.font = UIFont.systemFont(ofSize: 10 , weight: .semibold)
      
      if button.item.title == "" {
        //self.plusButton = button.item
        button.addTarget(self, action: #selector(self.plusButtonTapped), for: .touchUpInside)
      }
    }
    // 라인바
    BaseTabBarController.lineBar.indicator.tintColor = .mainOrange
    BaseTabBarController.lineBar.backgroundColor = .systemGray2
   
    addBar(BaseTabBarController.tabBar, dataSource: self, at: .bottom)
    addBar(BaseTabBarController.lineBar, dataSource: self, at: .bottom)
    
  }
  
  @objc func plusButtonTapped(_ sender: Any) {
    print("plusButtonTapped")
    let vc = UINavigationController(rootViewController: WritingViewController())
    //let vc = WritingViewController()
    vc.transitioningDelegate = self
    vc.modalPresentationStyle = .overCurrentContext
    present(vc, animated: true)
   
  }
  
  static func hideTabBar() {
    BaseTabBarController.lineBar.isHidden = true
    BaseTabBarController.tabBar.isHidden = true
  }
  
  static func showTabBar() {
    BaseTabBarController.lineBar.isHidden = false
    BaseTabBarController.tabBar.isHidden = false
  }
  
  
  
}

// MARK: - PageboyViewControllerDataSource, TMBarDataSource
extension BaseTabBarController: PageboyViewControllerDataSource, TMBarDataSource {
  func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return viewControllers.count
  }
  
  func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
    if index != 2 {
      return viewControllers[index]
    } else { // plus탭은 nil
      return nil
    }
    
  }
  
  func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    return .first
  }
  
  
  
  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
    let item = TMBarItem(title: titles[index])
    item.image = UIImage(named: images[index])
    item.selectedImage = UIImage(named: selectedImages[index])
    return item
  }
}


extension BaseTabBarController: UIViewControllerTransitioningDelegate {
  
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    SharedCircularTransition.transition.transitionMode = .present
    SharedCircularTransition.transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - 60)
    SharedCircularTransition.transition.circleColor = .mainOrange
    return  SharedCircularTransition.transition
  }
      
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    SharedCircularTransition.transition.transitionMode = .dismiss
    SharedCircularTransition.transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - 60)
    SharedCircularTransition.transition.circleColor = .mainOrange
    return  SharedCircularTransition.transition
  }
}
