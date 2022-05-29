//
//  DetailRestaurantViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/29.
//

import UIKit

class DetailRestaurantViewController: BaseViewController {

  @IBOutlet weak var detailRestaurantCollectionView: UICollectionView!
  var navigationTitle: String?
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigaionItem()
    detailRestaurantCollectionView.register(UINib(nibName: "FirstRestaurantDetailCell", bundle: .main), forCellWithReuseIdentifier: "FirstRestaurantDetailCell")
    detailRestaurantCollectionView.delegate = self
    detailRestaurantCollectionView.dataSource = self
  }
  
  func setNavigaionItem() {
    self.navigationController?.navigationBar.isTransparent = true
    
    if let navigationTitle = navigationTitle {
      self.navigationController?.navigationBar.tintColor = .mainOrange
      setNavigationBarBackbuttonTitle(title: navigationTitle)
    }
    UINavigationBar.appearance().tintColor = .mainOrange
    
    let cameraButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "camera", imageName: nil, tintColor: .mainOrange, width: 30, height: 25)
    let shareButton = self.navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "square.and.arrow.up", imageName: nil, tintColor: .mainOrange, width: 30, height: 25)
    
    self.navigationItem.rightBarButtonItems = [shareButton, cameraButton]
  }
}

extension DetailRestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = detailRestaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "FirstRestaurantDetailCell", for: indexPath) as? FirstRestaurantDetailCell else {
      print("cant")
      return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    return CGSize(width: collectionView.frame.size.width, height: 2000)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
  }
  
  
}
