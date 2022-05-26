//
//  MyPageSettingsViewController.swift
//  Mangoplate
//
//  Created by 임영선 on 2022/05/25.
//

import UIKit

class MyPageSettingsViewController: BaseViewController {

  @IBOutlet weak var settingsTableView: UITableView!
  let labels = [["언어", "알림", "식당등록"],
                ["공지사항", "고객센터", "도움말"],
                ["약관 및 정책", "접근권한 설정", "버전 정보"],
                ["로그아웃"],
                ["회원탈퇴"]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBarBackbuttonTitle(title: "설정")
    setNavigationTintColor(color: .mainOrange)
    
    settingsTableView.register(UINib(nibName: "MyPageSettingsCell", bundle: .main), forCellReuseIdentifier: "MyPageSettingsCell")
    settingsTableView.separatorInset.left = 0
    settingsTableView.delegate = self
    settingsTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationTitle(title: "", color: .mainLightGray)
  }
}

extension MyPageSettingsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return labels[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = settingsTableView.dequeueReusableCell(withIdentifier: "MyPageSettingsCell")
            as? MyPageSettingsCell else { return UITableViewCell() }
    cell.label.text = labels[indexPath.section][indexPath.row]
    
    // 회원탈퇴 셀 컬러 변경
    if indexPath.section == 4 {
      cell.label.textColor = .lightGray
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.5
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footer = UIView()
    footer.backgroundColor = .mainLightGray
    return footer
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 3 {
      print("로그아웃")
    }
    else if indexPath.section == 4 {
      let vc = UserDeleteViewController()
      vc.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
}
