//
//  RefreshBackDIYFooter.swift
//  Example
//
//  Created by zevwings on 2017/7/17.
//  Copyright © 2017年 zevwings. All rights reserved.
//

import UIKit

public class RefreshBackNativeFooter: RefreshBackStateFooter {
    
    // MARK: - Property
    
    public private(set) var arrowView: UIImageView?
    
    public private(set) var activityIndicator: UIActivityIndicatorView?
    
    
    // MARK: - Subviews
    
    override public func prepare() {
        super.prepare()
        
        self.labelInsetLeft = 24.0
        
        if arrowView == nil {
            arrowView = UIImageView()
            arrowView?.contentMode = .scaleAspectFit
            arrowView?.image = UIImage.arrow
            arrowView?.tintColor = .lightGray
            arrowView?.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
            addSubview(arrowView!)
        }
        
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator?.style = .gray
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.color = .lightGray
            addSubview(activityIndicator!)
        }
    }
    
    override public func placeSubViews() {
        super.placeSubViews()
        
        var centerX = frame.width * 0.5
        if let stateLabel = stateLabel, !stateLabel.isHidden {
            let labelWith = stateLabel.textWidth
            centerX -= (labelWith * 0.5 + labelInsetLeft + activityIndicator!.frame.width * 0.5)
        }
        let centerY = frame.height * 0.5
        let center = CGPoint(x: centerX, y: centerY)
        
        if let arrowView = arrowView, arrowView.constraints.count == 0 && arrowView.image != nil {
            arrowView.isHidden = false
            arrowView.frame.size = arrowView.image!.size
            arrowView.center = center
        } else {
            arrowView?.isHidden = true
        }
        
        if let activityIndicator = activityIndicator, activityIndicator.constraints.count == 0 {
            activityIndicator.center = center
        }
    }

    // MARK: - Do On State
    
    override public func doOnIdle(with oldState: CurrentState) {
        super.doOnIdle(with: oldState)
        
        if oldState == .refreshing {
            arrowView?.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
            UIView.animate(withDuration: 0.15, animations: {
                self.activityIndicator?.alpha = 0.0
            }, completion: { _ in
                self.activityIndicator?.alpha = 1.0
                self.activityIndicator?.stopAnimating()
                self.arrowView?.isHidden = false
            })
        } else {
            arrowView?.isHidden = false
            activityIndicator?.stopAnimating()
            UIView.animate(withDuration: 0.15, animations: {
                self.arrowView?.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
            })
        }
    }
    
    override public func doOnPulling(with oldState: CurrentState) {
        super.doOnPulling(with: oldState)
        
        arrowView?.isHidden = false
        activityIndicator?.stopAnimating()
        UIView.animate(withDuration: 0.15, animations: {
            self.arrowView?.transform = CGAffineTransform.identity
        })
    }
    
    override public func doOnRefreshing(with oldState: CurrentState) {
        super.doOnRefreshing(with: oldState)
        
        arrowView?.isHidden = true
        activityIndicator?.startAnimating()
    }
    
    override public func doOnNoMoreData(with oldState: CurrentState) {
        super.doOnNoMoreData(with: oldState)
        
        arrowView?.isHidden = true
        activityIndicator?.stopAnimating()
    }
}
