//
//  VideoLoginController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/20.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class VideoLoginController: VideoBelowController, UIGestureRecognizerDelegate {
    
    let buttonHeight:CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        setupVideoBelow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(80)
        }
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(UIDevice.width/2)
            make.height.equalTo(buttonHeight)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(0)
            }
        }
        signupButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(loginButton.snp.bottom)
            make.width.equalTo(UIDevice.width/2)
            make.height.equalTo(buttonHeight)
        }
    }
    
    func initSubviews() {
        title = "视频背景"
        view.addSubview(logoImageView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.backgroundColor = UIColor.background
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    lazy var loginButton = UIButton(type: .custom).then {
        $0.setTitle("LOG IN", for: .normal)
        $0.setTitleColor(UIColor.background, for: .normal)
        $0.titleLabel?.font = UIFont.scMediumFont(size: 20)
        $0.backgroundColor = UIColor(red: 35/255.0, green: 36/255.0, blue: 38/255.0, alpha: 1)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    lazy var signupButton = UIButton(type: .custom).then {
        $0.setTitle("SIGN UP", for: .normal)
        $0.setTitleColor(UIColor.background, for: .normal)
        $0.titleLabel?.font = UIFont.scMediumFont(size: 20)
        $0.backgroundColor = UIColor(red: 42/255.0, green: 183/255.0, blue: 90/255.0, alpha: 1)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    func setupVideoBelow() {
        let videoPath = Bundle.main.path(forResource: "moments", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: videoPath!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        alpha = 0.8
        contentURL = videoURL
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

