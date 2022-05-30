//
//  ReviewWritingViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class ReviewWritingViewController: BaseViewController {

  @IBOutlet weak var storeTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    storeTableView.register(UINib(nibName: "StoreCell", bundle: .main), forCellReuseIdentifier: "StoreCell")
    storeTableView.delegate = self
    storeTableView.dataSource = self
    setNavigaionBar()
  }
  
  func setNavigaionBar() {
    setNavigationTitle(title: "리뷰 쓰기", color: .mainOrange)
    self.navigationItem.setHidesBackButton(true, animated: false) // 백버튼 지움
    
    self.navigationController?.navigationBar.isTransparent = true
    
    let cancelButton = self.navigationItem.setNavigationItemButton(self, action: #selector(cancelButtonTapped), symbolName: nil, imageName: "xButton", tintColor: .mainLightGray2, width: 25, height: 25)
    
    self.navigationItem.rightBarButtonItems = [cancelButton]
  }
  
  @objc func cancelButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: false, completion: nil)
  }
}

extension ReviewWritingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = storeTableView.dequeueReusableCell(withIdentifier: "StoreCell")
            as? StoreCell else { return UITableViewCell() }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
}
