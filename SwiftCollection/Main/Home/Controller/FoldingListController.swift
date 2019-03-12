//
//  FoldingListController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/3/12.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class FoldingListController: UIViewController {
    
    var helpArray: [[String: String]] = [[: ]]
    var foldingStates: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        setupHelpData()
    }
    
     override func viewDidLayoutSubviews() {
        foldingTable.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "帮助中心"
        view.addSubview(foldingTable)
        view.backgroundColor = UIColor.background
    }
    
    func setupHelpData() {
        let helpPath = Bundle.main.path(forResource: "help", ofType: "plist")!
        helpArray = NSArray(contentsOfFile: helpPath) as! [[String : String]]
        for _ in 0..<helpArray.count { foldingStates.append(false) }
        foldingTable.reloadData()
    }
    
    lazy var foldingTable = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 44.0
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.background
    }
    
}

extension FoldingListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = helpArray[section].keys.first ?? ""
        let headerView = FoldingHeader(frame: CGRect(x: 0, y: 0, width: UIDevice.width, height: 50)).then {
            $0.titleLabel.text = title
            $0.foldingButton.isSelected = foldingStates[section]
            $0.foldingBlock = {
                self.foldingStates[section] = !self.foldingStates[section]
                self.foldingTable.reloadSections(IndexSet.init(integer: section), with: UITableView.RowAnimation.automatic)
            }
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return helpArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldingStates[section] ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "folding"
        let title = helpArray[indexPath.section].keys.first
        let content = helpArray[indexPath.section][title!]
        let cell = FoldingCell(style: .default, reuseIdentifier: indentifier)
        cell.contentLabel.text = content
        cell.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.bottom.equalTo(-10)
            make.right.equalTo(-15)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
    
}
