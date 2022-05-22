//
//  BaseTabBarController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
  
  let restaurantVC = RestaurantViewController()
  let mangoPickVC = MangoPickViewController()
  let writingVC = WritingViewController()
  let newsVC = NewsViewController()
  let mypageVC = MypageViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let firstVC = UINavigationController(rootViewController: restaurantVC)
    let secondVC = UINavigationController(rootViewController: mangoPickVC)
    let thirdVC = UINavigationController(rootViewController: writingVC)
    let fourthVC = UINavigationController(rootViewController: newsVC)
    let fifthVC = UINavigationController(rootViewController: mypageVC)
    
    firstVC.tabBarItem = UITabBarItem(title: "맛집찾기", image: UIImage(named: "tabbar1"), selectedImage: UIImage(named: "select_tabbar1"))
    secondVC.tabBarItem = UITabBarItem(title: "망고픽", image: UIImage(named: "tabbar2"), selectedImage: UIImage(named: "select_tabbar2"))
    thirdVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar3"), selectedImage: nil)
    fourthVC.tabBarItem = UITabBarItem(title: "소식", image: UIImage(named: "tabbar4"), selectedImage: UIImage(named: "select_tabbar4"))
    fifthVC.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "tabbar5"), selectedImage: UIImage(named: "select_tabbar5"))
    
    
    self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
    self.delegate = self
    
    UITabBar.appearance().tintColor = .mainOrange
    UITabBar.appearance().isTranslucent = false
    UITabBar.appearance().backgroundColor = .white
  }
}
