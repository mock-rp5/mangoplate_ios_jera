//
//  EATDealViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class EATDealViewController: BaseViewController {

  @IBOutlet weak var locationButton: UIButton!
  @IBOutlet weak var eatDealTableView: UITableView!
  var eatDeals: [EATDealResult]?
  var images: [UIImage]  = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationButton.layer.borderColor = UIColor.mainOrange.cgColor
    locationButton.layer.borderWidth = 1
    locationButton.layer.cornerRadius = 15
    locationButton.setTitleColor(.mainOrange, for: .normal)
    locationButton.tintColor = .mainOrange
    eatDealTableView.register(UINib(nibName: "EATDealCell", bundle: .main), forCellReuseIdentifier: "EATDealCell")
    eatDealTableView.dataSource = self
    eatDealTableView.delegate = self
    
    showIndicator()
    MangoPickDataManager().getEATDeal(viewController: self)
  }
  
  // 이미지 미리 로드
  private func imagesLoad() {
    if let eatDeals = eatDeals {
      for eatDeal in eatDeals {
        images.append(convertURLtoImage(urlString: eatDeal.thumbnailPhotoUrl ?? ""))
      }
    }
  }

}

extension EATDealViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let eatDeals = eatDeals {
      return eatDeals.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = eatDealTableView.dequeueReusableCell(withIdentifier: "EATDealCell")
            as? EATDealCell else { return UITableViewCell() }
    if let eatDeals = eatDeals {
      cell.titleLabel.text = eatDeals[indexPath.row].storeName
      cell.menuLabel.text = eatDeals[indexPath.row].menuName
      cell.dicountLabel.text = eatDeals[indexPath.row].discount
      cell.priceLabel.text = "₩" + String(eatDeals[indexPath.row].originalPrice).insertComma
      cell.priceLabel.attributedText = cell.priceLabel.text?.strikeThrough() // 가운데 줄
      
      cell.salePriceLabel.text = "₩" + String(eatDeals[indexPath.row].salePrice).insertComma
      
      // new가 1이면 보이게
      if eatDeals[indexPath.row].isNew == 1 {
        cell.newView.isHidden = false
      } else {
        cell.newView.isHidden = true
      }
      
      // 이미지가 삽입
      cell.foodImageView.image = images[indexPath.row]

    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
  }
}

// MARK: - API
extension EATDealViewController {
  func succeessGetEATDeal(results: [EATDealResult]) {
    self.eatDeals = results
    eatDealTableView.reloadData()
    imagesLoad()
    dismissIndicator()
  }
  
  func failedGetEATDeal(message: String) {
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
