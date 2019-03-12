//
//  FoldingCell.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/3/12.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class FoldingCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        selectionStyle = .none
        backgroundColor = UIColor.background
        addSubview(contentLabel)
    }
    
    lazy var contentLabel: UILabel = {
        let tempLabel: UILabel = UILabel(textColor: UIColor.commonText, font: UIFont.scRegularFont(size: 15), aligment: .left)
        tempLabel.frame = CGRect.zero
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
