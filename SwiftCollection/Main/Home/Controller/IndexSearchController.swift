//
//  IndexSearchController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/3/1.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import HandyJSON

class IndexSearchController: UIViewController {
    
    let cellHeight: CGFloat = 45.0
    let indexTitleHeight: CGFloat = 15.0
    var sortedBank: [String: [Bank]] = [: ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBankData()
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        indexTable.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(0)
            }
        }
        alertLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(90.0)
        }
    }
    
    func initSubviews() {
        title = "索引搜索"
        view.backgroundColor = UIColor.background
        view.addSubview(indexTable)
        view.addSubview(alertLabel)
    }
    
    lazy var indexTable = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.background
        $0.sectionIndexColor = UIColor.main
    }
    
    lazy var alertLabel = UILabel(CGRect.zero, text: "", textColor: UIColor.main, font: UIFont.scSemiboldFont(size: 30), aligment: .center).then {
        $0.backgroundColor = UIColor.line
        $0.layer.cornerRadius = 10.0
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    var upperKeys: [String] {
        var newKeys: [String] = []
        for key in sortedBank.keys.sorted() { newKeys.append(key.uppercased()) }
        return newKeys
    }
    
    func initBankData() {
        let bankPath = Bundle.main.path(forResource: "bank", ofType: "json")!
        do {
            let bankJson = try String(contentsOfFile: bankPath, encoding: String.Encoding.utf8)
            let banks = Banks.deserialize(from: bankJson)
            self.getSortedBank(bankArray: (banks?.data)!)
        } catch { }
    }
    
    func getSortedBank(bankArray: [Bank]) {
        for bank in bankArray {
            let bankFirstLetter = bank.name.chineseToPinYin(.firstLetter)
            if sortedBank.keys.contains(bankFirstLetter) {
                sortedBank[bankFirstLetter]?.append(bank)
            } else {
                sortedBank[bankFirstLetter] = [bank]
            }
        }
        UIView.animate(withDuration: 0.001, animations: {
            self.indexTable.reloadData()
        }) { (complete) in
            self.addIndexViewGesture()
        }
    }
    
    func addIndexViewGesture() {
        for subView in indexTable.subviews {
            print(subView)
            if subView.width == 15.0 && subView.x == UIDevice.width-15.0 {
                subView.gestureRecognizers = nil
                subView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(indexTitlesPan(_:))))
            }
        }
    }
    
    @objc fileprivate func indexTitlesPan(_ gesture: UIPanGestureRecognizer) {
        // 计算点击到哪个索引
        let indexCount = sortedBank.keys.count
        let indexHeight = CGFloat(indexCount)*indexTitleHeight
        let startY = (UIDevice.height-UIDevice.naviBarHeight-indexHeight)/2
        
        let offsetY = gesture.location(in: gesture.view).y
        var selectIndex = Int((offsetY - startY)/indexTitleHeight)
        selectIndex = selectIndex < 0 ? 0 : selectIndex > indexCount-1 ? indexCount-1 : selectIndex
        
        alertLabel.isHidden = gesture.state == .ended
        alertLabel.text = upperKeys[selectIndex]
        
        indexTable.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: false)
    }
    
}

extension IndexSearchController: UITableViewDelegate, UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return upperKeys
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = sortedBank.keys.sorted()[section].uppercased()
        let titleLabel = UILabel(CGRect(x: 15, y: 0, width: UIDevice.width-15, height: 30), text: title, textColor: UIColor.mainText, font: UIFont.scSemiboldFont(size: 18), aligment: .left)
        let headerView = UIView().then {
            $0.frame = CGRect(x: 0, y: 0, width: UIDevice.width, height: 30)
            $0.backgroundColor = UIColor.hex("eeeeee")
            $0.addSubview(titleLabel)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedBank.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sortedBank[sortedBank.keys.sorted()[section]]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "index"
        let bankArray = sortedBank[sortedBank.keys.sorted()[indexPath.section]]
        let cell = UITableViewCell(style: .default, reuseIdentifier: indentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = bankArray![indexPath.row].name
        cell.textLabel?.font = UIFont.scRegularFont(size: 15)
        cell.textLabel?.textColor = UIColor.commonText
        return cell
    }
    
}
