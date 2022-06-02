//
//  StarViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import UIKit

class StarViewController: BaseViewController {

  @IBOutlet weak var starTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    starTableView.register(UINib(nibName: "StarCell", bundle: .main), forCellReuseIdentifier: "StarCell")
    starTableView.delegate = self
    starTableView.dataSource = self
    starTableView.contentInset.right = -5
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBarBackbuttonTitle(title: "가고싶다")
    setNavigationTintColor(color: .mainOrange)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    BaseTabBarController.showTabBar()
  }
}

extension StarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = starTableView.dequeueReusableCell(withIdentifier: "StarCell")
            as? StarCell else { return UITableViewCell() }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }
  
}
