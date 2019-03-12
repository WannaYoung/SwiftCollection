//
//  PasswordController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/15.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class PasswordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        passwordView.snp.makeConstraints { (make) in
            make.centerY.equalTo(UIDevice.height/3)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "支付密码"
        view.addSubview(passwordView)
        _ = passwordView.becomeFirstResponder()
        view.backgroundColor = UIColor.background
    }
    
    lazy var passwordView = PasswordInputView().then {
        $0.delegate = self
    }
}

extension PasswordController: PasswordInputViewDelegate {
    
    func passwordInputViewBeginInput(passwordInputView: PasswordInputView) -> Void {
        print("开始输入")
    }
    
    func passwordInputViewDidChange(passwordInputView: PasswordInputView) -> Void {
        print("正在输入")
    }
    
    func passwordInputViewDidDeleteBackward(passwordInputView: PasswordInputView) -> Void {
        print("点击删除")
    }
    
    func passwordInputViewCompleteInput(passwordInputView: PasswordInputView) -> Void {
        _ = passwordInputView.resignFirstResponder()
        print("输入完毕")
    }
    
    func passwordInputViewEndInput(passwordInputView: PasswordInputView) -> Void {
        print("结束输入")
    }
    
}
