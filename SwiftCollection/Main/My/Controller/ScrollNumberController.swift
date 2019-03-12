//
//  ScrollNumberController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/18.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class ScrollNumberController: UIViewController {

    let numbers = [2654, 462976, 42.56, -256924, -55, -42532.74, -3.5, -9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
   func initSubviews() {
        title = "滚动数字"
        view.addSubview(startButton)
        view.addSubview(scrollNumberView)
        view.backgroundColor = UIColor.background
    }
    
    lazy var scrollNumberView = ScrollNumberView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        $0.center = CGPoint(x: view.center.x, y: view.center.y-120)
    }
    
    lazy var startButton = UIButton(type: .custom).then {
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        $0.center = view.center
        $0.setTitle("START", for: .normal)
        $0.setTitleColor(UIColor.brown, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.addTarget(self, action: #selector(scrollNumber), for: .touchUpInside)
    }
    
    @objc func scrollNumber() {
        let number = NSNumber(value: numbers.randomElement()!)
        scrollNumberView.frame = CGRect(x: 0, y: 0, width: number.stringValue.count*25, height: 60)
        scrollNumberView.center = CGPoint(x: view.center.x, y: view.center.y-120)
        scrollNumberView.number = number
        scrollNumberView.startAnimation()
    }
}
