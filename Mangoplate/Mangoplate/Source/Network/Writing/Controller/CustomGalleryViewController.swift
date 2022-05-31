//
//  CustomGalleryViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/31.
//

import UIKit
import Photos

class CustomGalleryViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var customGalleryCollectionView: UICollectionView!
  @IBOutlet weak var bottomView: UIView!
  @IBOutlet weak var jumpButton: UIButton!
  @IBOutlet weak var okButton: UIButton!
  var selectImageCount = 0
  var isSelected: [Bool] = []
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    customGalleryCollectionView.register(UINib(nibName: "CustomGalleryCell", bundle: .main), forCellWithReuseIdentifier: "CustomGalleryCell")
    customGalleryCollectionView.delegate = self
    customGalleryCollectionView.dataSource = self
    okButton.isEnabled = false
    okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
    jumpButton.addTarget(self, action: #selector(jumpButtonTapped(_:)), for: .touchUpInside)
    
    // 사진 모두 선택 안한걸로 셋팅
    for _ in 0..<photocount {
      isSelected.append(false)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitle(title: "리뷰쓰기", color: .mainOrange)
    setNavigationTintColor(color: .mainOrange)
    setNavigationBarBackbuttonTitle(title: "")
  }
  
  // MARK: - Mehtods
  
  // asset을 UIImage로 바꿔줌
  func assetToImage(asset: PHAsset) -> UIImage {
    var image = UIImage()
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.deliveryMode = .opportunistic
    manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: options, resultHandler: {(result, info)->Void in
        image = result!
    })
    return image
  }
  
  // 확인버튼 클릭 : 선택된 사진을 asset -> UIImage -> Data로 형 변환해서 Review에 저장 (싱글턴패턴)
  @objc func okButtonTapped(_ sender: UIButton) {
    var images: [Data] = []
    for (index, value) in isSelected.enumerated() {
      // 선택된 사진이면
      if value == true {
        if let asset = allPhotos?.object(at: index) {
          let image = assetToImage(asset: asset) // asset -> UIImage
          guard let data = image.jpegData(compressionQuality: 0.1)  else { return }// UIImage -> Data
          images.append(data)
        }
      }
    }
    
    Review.shared.images = images
    
    let vc = ReviewWritingViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func jumpButtonTapped(_ sender: UIButton) {
    let vc = ReviewWritingViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }

}

extension CustomGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    print("photocount \(photocount)")
   return photocount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = customGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomGalleryCell", for: indexPath)
            as? CustomGalleryCell else { return UICollectionViewCell() }
    
    if let asset = allPhotos?.object(at: indexPath.row) {
      print("asset")
      cell.imgView.image = assetToImage(asset: asset)
    }
    cell.countView.isHidden = true
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = customGalleryCollectionView.frame.size.width/4 - 1.5
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = customGalleryCollectionView.cellForItem(at: indexPath)
            as? CustomGalleryCell else { return }
    
    // 선택되지 않은 상태였다면
    if isSelected[indexPath.row] == false {
      isSelected[indexPath.row] = true
      selectImageCount += 1
      cell.imgView.alpha = 0.7
      cell.countView.isHidden = false
      cell.countLabel.text = String(selectImageCount)
      self.okButton.setTitle("확인 (\(String(selectImageCount))/30)", for: .normal)
      
      if selectImageCount > 0 {
        self.bottomView.backgroundColor = .mainOrange
        self.okButton.isEnabled = true
      }
    }
    
    // 선택된 상태였다면
    else {
      isSelected[indexPath.row] = false
      selectImageCount -= 1
      cell.imgView.alpha = 1
      cell.countView.isHidden = true
      cell.countLabel.text = ""
      self.okButton.setTitle("확인 (\(String(selectImageCount))/30)", for: .normal)
      
      if selectImageCount <= 0 {
        self.bottomView.backgroundColor = .lightGray
        self.okButton.isEnabled = false
      }
    }
    
 
  }
  
}
