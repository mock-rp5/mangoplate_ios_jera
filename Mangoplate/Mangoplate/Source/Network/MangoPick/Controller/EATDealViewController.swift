//
//  EATDealViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class EATDealViewController: UIViewController {

  @IBOutlet weak var locationButton: UIButton!
  @IBOutlet weak var eatDealTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationButton.layer.borderColor = UIColor.mainOrange.cgColor
    locationButton.layer.borderWidth = 1
    locationButton.layer.cornerRadius = 15
    eatDealTableView.register(UINib(nibName: "EATDealCell", bundle: .main), forCellReuseIdentifier: "EATDealCell")
    eatDealTableView.dataSource = self
    eatDealTableView.delegate = self
  }
}

extension EATDealViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = eatDealTableView.dequeueReusableCell(withIdentifier: "EATDealCell")
            as? EATDealCell else { return UITableViewCell() }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
  }
  
  
}
