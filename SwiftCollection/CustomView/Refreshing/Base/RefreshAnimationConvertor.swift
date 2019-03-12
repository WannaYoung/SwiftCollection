//
//  Protocols.swift
//  Pods-Example
//
//  Created by zevwings on 01/02/2018.
//

import UIKit

public protocol RefreshAnimationConvertor: AnyObject {
    
    var stateImages: [RefreshComponent.CurrentState: [UIImage]]? { get set }
    var stateDurations: [RefreshComponent.CurrentState: TimeInterval]? { get set }
    
    var animationView: UIImageView? { get }
    
    func setImages(_ images: [UIImage], for state: RefreshComponent.CurrentState)
    func setImages(_ images: [UIImage], duration: TimeInterval, for state: RefreshComponent.CurrentState)
    
    func pullAnimation(with pullPercent: CGFloat)
    func startAnimating()
    func stopAnimating()
}

public extension RefreshAnimationConvertor where Self: RefreshComponent {
    
    func setImages(_ images: [UIImage], for state: CurrentState) {
        setImages(images, duration: Double(images.count) * 0.1, for: state)
    }
    
    func setImages(_ images: [UIImage], duration: TimeInterval, for state: CurrentState) {
        
        guard images.count > 0 else { return }
        
        if stateImages == nil { stateImages = [:] }
        if stateDurations == nil { stateDurations = [:] }
        
        stateImages?[state] = images
        stateDurations?[state] = duration
        if let image = images.first, image.size.height > frame.height {
            frame.size.height = image.size.height
        }
    }
    
    func pullAnimation(with pullPercent: CGFloat) {
        
        guard let images = stateImages?[.idle], images.count > 0, refreshState == .idle else { return }
        
        animationView?.stopAnimating()
        
        var idx = Int(CGFloat(images.count) * pullingPercent)
        if idx >= images.count { idx = images.count - 1 }
        animationView?.image = images[idx]
        
        if pullingPercent > 1.0 {
            startAnimating()
        }
    }
    
    func startAnimating() {
        
        guard let images = stateImages?[.refreshing], images.count > 0 else { return }
        
        animationView?.stopAnimating()
        
        if images.count == 1 {
            animationView?.image = images.last
        } else {
            animationView?.animationImages = images
            animationView?.animationDuration = stateDurations?[.refreshing] ?? 0.0
            animationView?.startAnimating()
        }
    }
    
    func stopAnimating() {
        animationView?.stopAnimating()
    }
}
