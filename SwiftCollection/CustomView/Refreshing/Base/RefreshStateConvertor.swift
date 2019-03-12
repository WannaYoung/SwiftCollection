//
//  RefreshStateComponent.swift
//  Pods-Example
//
//  Created by zevwings on 01/02/2018.
//

import UIKit

public protocol RefreshStateConvertor: AnyObject {
    
    var labelInsetLeft: CGFloat { get set }
    
    var stateLabel: UILabel? { get }

    var stateTitles: [RefreshComponent.CurrentState : String]? { get set }
 
    func setCurrentStateTitle()
    
    func setTitle(_ title: String, for state: RefreshComponent.CurrentState)
}

public extension RefreshStateConvertor where Self: RefreshComponent {
    
    func setCurrentStateTitle() {
        guard let _stateLabel = stateLabel else { return }
        if _stateLabel.isHidden && refreshState == .refreshing {
            _stateLabel.text = nil
        } else {
            _stateLabel.text = stateTitles?[refreshState]
        }
    }
    
    func setTitle(_ title: String, for state: CurrentState) {
        if stateTitles == nil { stateTitles = [:] }
        stateTitles?[state] = title
        stateLabel?.text = stateTitles?[refreshState]
    }
}
