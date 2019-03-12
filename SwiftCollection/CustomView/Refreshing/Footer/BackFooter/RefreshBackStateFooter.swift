//
//  ZRefreshBackStateFooter.swift
//
//  Created by zevwings on 16/4/1.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

open class RefreshBackStateFooter: RefreshBackFooter {
    
    // MARK: - Property
    
    public var labelInsetLeft: CGFloat = 12.0
    public var stateTitles: [CurrentState : String]?
    public private(set) var stateLabel: UILabel?
    
    // MARK: - Subviews
    
    override open func prepare() {
        super.prepare()
        
        if stateLabel == nil {
            stateLabel = .default
            addSubview(stateLabel!)
        }
        
        setTitle(localized(string: LocalizedKey.Footer.Back.idle), for: .idle)
        setTitle(localized(string: LocalizedKey.Footer.Back.pulling), for: .pulling)
        setTitle(localized(string: LocalizedKey.Footer.Back.refreshing), for: .refreshing)
        setTitle(localized(string: LocalizedKey.Footer.Back.noMoreData), for: .noMoreData)
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if let stateLabel = stateLabel, stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    // MARK: - Do On State
    
    override open func doOnAnyState(with oldState: CurrentState) {
        super.doOnAnyState(with: oldState)
        
        setCurrentStateTitle()
    }
}

// MARK: - Override

extension RefreshBackStateFooter {
    
    override open var tintColor: UIColor! {
        didSet {
            stateLabel?.textColor = tintColor
        }
    }
}

// MARK: - RefreshStateComponent

extension RefreshBackStateFooter: RefreshStateConvertor {}

