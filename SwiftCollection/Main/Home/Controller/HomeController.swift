//
//  HomeController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/1.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    
    let secureTitles = ["Header放大", "我的位置", "图片缩放", "swipe列表", "视频背景", "3D Touch", "网格编辑", "索引搜索", "折叠列表"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        title = "主页"
        view.addSubview(secureTable)
        view.backgroundColor = UIColor.background
    }
    
    lazy var secureTable = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.background
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
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
        let secureController = [HeaderScaleController(), FindMeController(), ScaleImageController(), SwipeCellController(), VideoLoginController(), TouchPreviewController(), MovableGridController(), IndexSearchController(), FoldingListController()][indexPath.row]
        secureController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(secureController, animated: true)
    }
    
}
