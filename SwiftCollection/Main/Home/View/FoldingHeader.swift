//
//  FoldingHeader.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/3/12.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

typealias FoldingBlock = () -> ()

class FoldingHeader: UIView {

    var foldingBlock: FoldingBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(foldingButton)
        backgroundColor = UIColor.hex("f8f8f8")
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
        foldingButton.snp.makeConstraints { (make) in
            make.edges.equalTo(titleLabel)
        }
    }
    
    lazy var titleLabel = UILabel(textColor: UIColor.mainText, font: UIFont.scMediumFont(size: 17), aligment: .left).then { _ in }
    
    lazy var foldingButton = UIButton(type: .custom).then {
        $0.contentHorizontalAlignment = .right
        $0.setImage(UIImage(named: "icon_down"), for: .normal)
        $0.setImage(UIImage(named: "icon_up"), for: .selected)
        $0.addTarget(self, action: #selector(foldCell(sender:)), for: .touchUpInside)
    }
    
    @objc func foldCell(sender: UIButton) {
        foldingBlock!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
