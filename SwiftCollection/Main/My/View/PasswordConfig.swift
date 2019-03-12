//
//  PasswordConfig.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/14.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class PasswordConfig: NSObject {
    
    ///密码的位数
    var passwordNum: UInt = 6
    ///边框矩形宽度
    var squareWidth: CGFloat = 45
    ///黑点的半径
    var pointRadius: CGFloat = 18 * 0.5
    ///边距相对中间间隙倍数
    var spaceMultiple: CGFloat = 4;
    ///黑点颜色
    var pointColor: UIColor = UIColor.commonText
    ///边框宽度
    var rectBorderWidth: CGFloat = 1.2
    ///边框颜色
    var rectColor: UIColor = UIColor.main
    ///边框圆角
    var rectCornerRadius: CGFloat = 5.0
    ///输入框背景颜色
    var rectBackgroundColor: UIColor = UIColor.white
    ///控件背景颜色
    var backgroundColor: UIColor = UIColor.white
    
    class func defaultConfig() -> PasswordConfig {
        let config = PasswordConfig()
        return config
    }
    
}
