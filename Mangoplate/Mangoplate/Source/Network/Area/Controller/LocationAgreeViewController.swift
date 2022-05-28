//
//  LocationAgreeViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/28.
//

import UIKit
import CoreLocation

class LocationAgreeViewController: UIViewController, CLLocationManagerDelegate {

  @IBOutlet weak var agreeButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    agreeButton.layer.cornerRadius = 30
    agreeButton.addTarget(self, action: #selector(agreeButtonTapped(_:)), for: .touchUpInside)
    cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)

  }
  
  @objc func agreeButtonTapped(_ sender: UIButton) {
    let locationManager = CLLocationManager()
    
    // 위치추적 권한 요청
    locationManager.requestWhenInUseAuthorization()
    
    // 배터리에 맞게 권장되는 최적의 정확도
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    let vc = BaseTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
  }
  
  @objc func cancelButtonTapped(_ sender: UIButton) {
    let vc = BaseTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
  }

}
