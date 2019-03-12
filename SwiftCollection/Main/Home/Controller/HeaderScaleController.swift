//
//  FontFamilyController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/19.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class HeaderScaleController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        fontTable.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "Header放大"
        view.addSubview(fontTable)
        view.backgroundColor = UIColor.background
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    lazy var fontTable = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.tableHeaderView = headerView
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.background
    }
    
    lazy var headerView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: UIDevice.width, height: 188)
        $0.addSubview(headerImage)
        $0.backgroundColor = UIColor.background
    }
    
    lazy var headerImage = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: UIDevice.width, height: 188)
        $0.image = UIImage(named: "header")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = UIColor.background
    }
    
}

extension HeaderScaleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "font"
        let cell = UITableViewCell(style: .default, reuseIdentifier: indentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = UIFont.familyNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HeaderScaleController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        headerImage.frame = offsetY < 0 ? CGRect(x: offsetY, y: offsetY, width: UIDevice.width - offsetY*2, height: 188 - offsetY) : CGRect(x: 0, y: 0, width: UIDevice.width, height: 188)
    }

}
