//
//  StarViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/06/02.
//

import UIKit

class StarViewController: BaseViewController {

  @IBOutlet weak var starTableView: UITableView!
  var stars: [WantedResult]?
  
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
    showIndicator()
    MyPageDataManager().getMyStar(viewController: self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    BaseTabBarController.showTabBar()
  }
}

extension StarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let stars = stars {
      return stars.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = starTableView.dequeueReusableCell(withIdentifier: "StarCell")
            as? StarCell else { return UITableViewCell() }
    if let stars = stars  {
      let star = stars[indexPath.row]
      cell.watchingLabel.text = String(star.viewCount).insertComma
      cell.writingLabel.text = String(star.reviewCount).insertComma
      cell.storeNameLabel.text = star.storeName
      cell.locationLabel.text = star.detailAreaName
      cell.foodImageView.load(urlString: star.thumbnailImgUrl)
      cell.scoreLabel.text = star.score
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }
}

// MARK: - API
extension StarViewController {
  func successGetStars(results: [WantedResult]) {
    print("successGetStars")
    self.stars = results
    starTableView.reloadData()
    dismissIndicator()
  }
  
  func failedGetStars(message: String) {
    print("failedGetStars")
    presentBottomAlert(message: message)
    dismissIndicator()
  }
}
