//
//  ReviewWritingViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit

class ReviewStoresViewController: BaseViewController {

  @IBOutlet weak var storeTableView: UITableView!
  var stores: [StoreSearchResult]?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    showIndicator()
    storeTableView.register(UINib(nibName: "StoreCell", bundle: .main), forCellReuseIdentifier: "StoreCell")
    storeTableView.delegate = self
    storeTableView.dataSource = self
    WritingDataManager().getStores(viewController: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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

extension ReviewStoresViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let stores = stores {
      return stores.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = storeTableView.dequeueReusableCell(withIdentifier: "StoreCell")
            as? StoreCell else { return UITableViewCell() }
    if let stores = stores {
      cell.storeLabel.text = stores[indexPath.row].storeName
      cell.locationLabel.text = stores[indexPath.row].description
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let stores = stores {
      Review.shared.storeId = stores[indexPath.row].storeId
    }
    
    let vc = CustomGalleryViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK: - API
extension ReviewStoresViewController {
  func successGetStores(results: [StoreSearchResult]) {
    print("successGetStores")
    self.stores = results
    storeTableView.reloadData()
    dismissIndicator()
  }
  
  func failedGetStores(message: String) {
    print("failedGetStores")
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
