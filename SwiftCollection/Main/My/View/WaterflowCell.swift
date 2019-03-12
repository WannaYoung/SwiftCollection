//
//  WaterflowCell.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/15.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class WaterflowCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(avatorImage)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(unsplashImage)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        backgroundColor = UIColor.background
    }
    
    override func layoutSubviews() {
        avatorImage.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(-10)
            make.width.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatorImage.snp.right).offset(5)
            make.bottom.equalTo(avatorImage.snp.bottom)
            make.right.equalTo(-5)
            make.height.equalTo(15)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatorImage.snp.top)
            make.left.equalTo(avatorImage.snp.right).offset(5)
            make.bottom.equalTo(dateLabel.snp.top)
            make.right.equalTo(-5)
        }
        unsplashImage.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(avatorImage.snp.top).offset(-10)
        }
    }
    
    lazy var avatorImage = UIImageView().then {
        $0.layer.cornerRadius = 15.0
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleToFill
    } //图标
    
    lazy var nameLabel = UILabel(textColor: UIColor.mainText, font: UIFont.scMediumFont(size: 13), aligment: .left).then {_ in
    } //数量
    
    lazy var dateLabel = UILabel(textColor: UIColor.assistText, font: UIFont.scMediumFont(size: 11), aligment: .left).then {_ in
    } //数量
    
    lazy var unsplashImage = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = UIColor.hex("#BEC2D9",alpha: 0.2)
    } //分割线
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
