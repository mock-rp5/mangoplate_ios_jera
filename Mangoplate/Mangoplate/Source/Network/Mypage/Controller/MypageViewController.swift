//
//  MypageViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/22.
//

import UIKit

class MypageViewController: BaseViewController {

  // MARK: - Properties
  @IBOutlet weak var myPageTableView: UITableView!
  
  let labels = [
    [],
    ["이벤트"],
    ["구매한 EAT딜", "EAT딜 입고알림"],
    [],
    ["가고싶다", "마이리스트", "북마크", "내가 등록한 식당"],
    ["설정"]
  ]
  
  let images = [
    [],
    ["mypage1"],
    ["mypage2", "mypage3"],
    [],
    ["mypage4", "mypage5", "mypage6", "mypage7"],
    ["mypage8"]
  ]
  
  var user: GetUserResult?
  
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    showIndicator()
    MyPageDataManager().getUser(viewController: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    BaseTabBarController.showTabBar()
    setNavigationTitle(title: "", color: .clear)
  }
  
  // MARK: - Methods
  private func setUI() {
    self.navigationController?.navigationBar.isTransparent = true
    let bellButton = navigationItem.setNavigationItemButton(nil, action: nil, symbolName: "bell", imageName: nil, tintColor: .darkGray, width: 25, height: 25)
    self.navigationItem.rightBarButtonItems = [bellButton]
    
    myPageTableView.delegate = self
    myPageTableView.dataSource = self
    myPageTableView.separatorInset.left = 0
    
    myPageTableView.register(UINib(nibName: "MyPageProfileCell", bundle: .main), forCellReuseIdentifier: "MyPageProfileCell")
    myPageTableView.register(UINib(nibName: "MyPageMainCell", bundle: .main), forCellReuseIdentifier: "MyPageMainCell")
    myPageTableView.register(UINib(nibName: "MyPageTimelineCell", bundle: .main), forCellReuseIdentifier: "MyPageTimelineCell")
  }
  
  @objc func myReviewTapped(_ sender: UIButton) {
    let vc = MyReviewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MypageViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 3:
      return 1
    default:
      return labels[section].count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell =  myPageTableView.dequeueReusableCell(withIdentifier: "MyPageProfileCell") as? MyPageProfileCell else {
        return UITableViewCell() }
      
      if let user = user {
        cell.nickNameLabel.text = user.userName
        cell.followerLabel.text = String(user.follower)
        cell.followingLabel.text = String(user.following)
        // 프로필 사진이 있으면 넣어줌
        if let stringUrl = user.userProfileImg {
          cell.profileImageView.load(urlString: stringUrl)
        }
      }
      return cell
    case 3:
      guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageTimelineCell") as? MyPageTimelineCell else { return UITableViewCell() }
      cell.reviewButton.addTarget(self, action: #selector(myReviewTapped), for: .touchUpInside)
      return cell
      
    default:
      guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageMainCell") as? MyPageMainCell else { return UITableViewCell() }
      cell.label.text = labels[indexPath.section][indexPath.row]
      cell.symbolImageView.image = UIImage(named: images[indexPath.section][indexPath.row])
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 115
    case 3:
      return 120
    default:
      return 60
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footer = UIView()
    footer.backgroundColor = .mainLightGray
    return footer
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if section == 3 {
      return 0.5
    } else {
      return 10
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    view.backgroundColor = .mainLightGray2
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // 설정 셀 클릭
    if indexPath.section == 5 {
      BaseTabBarController.hideTabBar()  // 탭바 숨김
      let vc = MyPageSettingsViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

// MARK: - API
extension MypageViewController {
  // 회원 조회
  func successGetUser(user: GetUserResult) {
    self.user = user
    print(user)
    myPageTableView.reloadData()
    dismissIndicator()
  }
  
  func failedGetUser(message: String) {
    self.presentBottomAlert(message: message)
    dismissIndicator()
  }
}
