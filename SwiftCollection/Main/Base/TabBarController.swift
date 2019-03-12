//
//  TabBarController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/14.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    let scanOffset: CGFloat = 8
    let tabTitles = ["主页", "", "示例"]
    let tabNormalImages = ["tab_news_normal", "", "tab_account_normal"]
    let tabSelectImages = ["tab_news_select", "", "tab_account_select"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabBar()
        initViewControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        scanButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(tabBar.snp.centerX)
            make.top.equalTo(tabBar.snp.top).offset(-scanOffset)
            make.width.equalTo(67)
            make.height.equalTo(56)
        }
    }
    
    func initTabBar() {
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.main
        tabBar.barTintColor = UIColor.background
        tabBar.shadowImage = UIImage()
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        tabBar.layer.shadowOpacity = 0.1
        tabBar.backgroundImage = UIImage(color: UIColor.background)
        tabBar.addSubview(scanButton)
    }
    
    //初始化ViewControllers
    func initViewControllers() {
        let homeNav = UINavigationController(rootViewController: HomeController())
        let myNav = UINavigationController(rootViewController: MyController())
        let tabNavs = [homeNav, UINavigationController(), myNav]
        
        for i in 0..<tabNavs.count {
            let navi = tabNavs[i]
            navi.tabBarItem.isEnabled = i != 1
            navi.tabBarItem.title = tabTitles[i]
            navi.tabBarItem.image = UIImage(named: tabNormalImages[i])?.withRenderingMode(.alwaysOriginal)
            navi.tabBarItem.selectedImage = UIImage(named: tabSelectImages[i])?.withRenderingMode(.alwaysOriginal)
            addChild(navi)
        }
    }
    
    lazy var scanButton: UIButton = {
        let tempButton: UIButton = UIButton(type: .custom)
        tempButton.layer.masksToBounds = true
        tempButton.contentMode = .center
        tempButton.setImage(UIImage(named: "tab_scan"), for: .normal)
        tempButton.addTarget(self, action: #selector(scanQRCode), for: .touchUpInside)
        return tempButton
    }()  //scan按钮
    
    //点击scan按钮
    @objc func scanQRCode() {
        
    }
    
}

//MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return (viewController as! UINavigationController).topViewController != nil
    }
}

//ScanButton越界部分可点击
extension UITabBar {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if clipsToBounds || isHidden || alpha == 0.0 {
            return nil
        }
        if let result = super.hitTest(point, with: event) {
            return result
        }
        for subView in subviews {
            let subPoint: CGPoint = subView.convert(point, from: self)
            if let result = subView.hitTest(subPoint, with: event)  {
                return result
            }
        }
        return nil
    }
}
