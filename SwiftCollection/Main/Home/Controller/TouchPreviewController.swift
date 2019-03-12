//
//  TouchPreviewController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/20.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import SafariServices

class TouchPreviewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "3D Touch"
        view.backgroundColor = UIColor.background
        let fingerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        fingerImage.center = view.center
        fingerImage.image = UIImage(named: "finger")
        fingerImage.isUserInteractionEnabled = true
        view.addSubview(fingerImage)
        registerForPreviewing(with: self, sourceView: fingerImage)
    }
}

extension TouchPreviewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // 通过上下文可以调整不被虚化的范围
        previewingContext.sourceRect = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: self.view.frame.height - 10)
        return SFSafariViewController(url: URL(string: "https://juejin.im")!)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }
}

extension SFSafariViewController {
    open override var previewActionItems: [UIPreviewActionItem] {
        let deleteAction = UIPreviewAction(title: "删除", style: .destructive) { (previewAction, vc) in
            print("Delete")
        }
        let doneAction = UIPreviewAction(title: "完成", style: .default) { (previewAction, vc) in
            print("Done")
        }
        return [deleteAction, doneAction]
    }
}

