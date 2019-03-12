//
//  ScaleImageController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/19.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class ScaleImageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIDevice.width)
            make.height.equalTo(UIDevice.height-UIDevice.naviBarHeight)
        }
    }
    
    func initSubviews() {
        title = "图片缩放"
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        view.backgroundColor = UIColor.background
    }

    lazy var scrollView = UIScrollView().then {
        $0.maximumZoomScale = 4.0
        $0.minimumZoomScale = 1.0
        $0.backgroundColor = UIColor.background
        $0.contentSize = imageView.bounds.size
        $0.delegate = self
    }
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "dog")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
}

extension ScaleImageController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
