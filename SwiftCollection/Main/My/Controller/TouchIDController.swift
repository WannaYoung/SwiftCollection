//
//  TouchIDController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/15.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class TouchIDController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        verifyButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        resultLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(verifyButton.snp.top).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func initSubviews() {
        title = "指纹认证"
        view.addSubview(resultLabel)
        view.addSubview(verifyButton)
        view.backgroundColor = UIColor.background
    }
    
    lazy var resultLabel = UILabel().then {
        $0.textColor = UIColor.mainText
        $0.textAlignment = .center
    }
    
    var verifyButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "finger"), for: .normal)
        $0.setTitleColor(UIColor.main, for: .normal)
        $0.addTarget(self, action: #selector(authTouchID), for: .touchUpInside)
    }
    
    lazy var touchIDAuth = TouchID().then {
        $0.touchIDReasonString = "轻触Home键验证指纹"
        $0.delegate = self
    }
    
    @objc func authTouchID() {
        touchIDAuth.touchIDAuthentication()
    }
}

extension TouchIDController: TouchIDDelegate {
    
    func touchIDAuthenticationWasSuccessful() {
        self.resultLabel.text = "指纹验证成功"
    }
    
    func touchIDAuthenticationFailed(_ errorCode: TouchIDErrorCode) {
        
        switch errorCode{
        case .touchID_CanceledByTheSystem:
            self.resultLabel.text = "系统取消验证"
        case .touchID_CanceledByTheUser:
            self.resultLabel.text = "用户取消验证"
        case .touchID_PasscodeNotSet:
            self.resultLabel.text = "没有设置解锁密码"
        case .touchID_TouchIDNotAvailable:
            self.resultLabel.text = "指纹解锁不可用"
        case .touchID_TouchIDNotEnrolled:
            self.resultLabel.text = "请轻触Home键验证指纹"
        case .touchID_UserFallback:
            self.resultLabel.text = "验证方式不被允许"
        default:
            self.resultLabel.text = "指纹验证失败"
        }
    }
}
