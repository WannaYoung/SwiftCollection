//
//  DigitalInputController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/18.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class DigitalInputController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        amountTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(UIDevice.height/3)
            make.width.equalTo(UIDevice.width/1.3)
            make.height.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "数字键盘"
        view.addSubview(amountTF)
        amountTF.becomeFirstResponder()
        view.backgroundColor = UIColor.background
    }
    
    lazy var amountTF = UITextField(placeholder: "请输入支付金额", font: UIFont.scRegularFont(size: 15)).then {
        $0.textColor = UIColor.mainText
        $0.borderStyle = .none
        $0.backgroundColor = UIColor.line
        $0.layer.cornerRadius = 5.0
        $0.addPaddingLeft(10.0)
        _ = DigitalKeyboard(self.view, accessoryView: nil, field: $0)
    }

}
