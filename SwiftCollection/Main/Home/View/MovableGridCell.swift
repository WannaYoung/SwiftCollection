//
//  MovableGridCell.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/28.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class MovableGridCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(iconImage)
        addSubview(titleLabel)
        
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        iconImage.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(snp.width)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    lazy var iconImage = UIImageView().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleToFill
    } //图标
    
    lazy var titleLabel = UILabel(textColor: UIColor.mainText, font: UIFont.scMediumFont(size: 13), aligment: .center).then {_ in
    } //数量
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
