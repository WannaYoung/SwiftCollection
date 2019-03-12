//
//  MyController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/14.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class MyController: UIViewController {
    
    let secureTitles = ["支付密码", "指纹认证", "瀑布流", "数字键盘", "滚动数字"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        secureTable.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "示例"
        view.addSubview(secureTable)
        view.backgroundColor = UIColor.background
    }
    
    lazy var secureTable = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.background
    }
    
}

extension MyController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secureTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "secure"
        let cell = UITableViewCell(style: .default, reuseIdentifier: indentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = secureTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secureController = [PasswordController(), TouchIDController(), WaterflowController(), DigitalInputController(), ScrollNumberController()][indexPath.row]
        secureController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(secureController, animated: true)
    }
    
}
