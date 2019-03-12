//
//  PasswordInputView.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/14.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class PasswordInputView: UIView {
    
    var delegate: PasswordInputViewDelegate?
    var config: PasswordConfig
    
    private (set) var text: NSMutableString = NSMutableString()
    private var isShow: Bool = false
    
    override init(frame: CGRect) {
        config = PasswordConfig.defaultConfig()
        super.init(frame: frame)
        backgroundColor = config.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasswordInputView {
    
    override func becomeFirstResponder() -> Bool {
        if !isShow {
            delegate?.passwordInputViewBeginInput(passwordInputView: self)
        }
        isShow = true;
        return super.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        if isShow {
            delegate?.passwordInputViewEndInput(passwordInputView: self)
        }
        isShow = false
        return super.resignFirstResponder()
    }
    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set {
            
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var canResignFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !isFirstResponder {
            _ = becomeFirstResponder()
        }
    }
    
    func updateWithConfig(config: ((PasswordConfig) -> Void)?) -> Void {
        config?(self.config)
        backgroundColor = self.config.backgroundColor
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.size.width
        let height = rect.size.height-config.rectBorderWidth*2
        let squareWidth = min(max(min(height, config.squareWidth), config.pointRadius * 4), height)
        let pointRadius = min(config.pointRadius, squareWidth * 0.5) * 0.8
        let middleSpace = CGFloat(width - CGFloat(config.passwordNum) * squareWidth) / CGFloat(CGFloat(config.passwordNum - 1) + config.spaceMultiple * 2)
        let leftSpace = middleSpace * config.spaceMultiple
        
        let context = UIGraphicsGetCurrentContext()
        for i in 0 ..< config.passwordNum {
            context?.saveGState()
            let rect = CGRect(x: leftSpace + CGFloat(i) * squareWidth + CGFloat(i) * middleSpace, y: config.rectBorderWidth, width: squareWidth, height: height)
            let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: config.rectCornerRadius).cgPath
            let linePath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: config.rectCornerRadius).cgPath
            
            context?.setFillColor(config.rectBackgroundColor.cgColor)
            context?.setStrokeColor(config.rectColor.cgColor)
            context?.setLineWidth(config.rectBorderWidth)
            context?.addPath(clipPath)
            context?.closePath()
            context?.fillPath()
            context?.addPath(linePath)
            context?.strokePath()
            context?.restoreGState()
        }
        
        context?.setFillColor(config.pointColor.cgColor)
        for i in 0 ..< text.length {
            context?.addArc(center: CGPoint(x: leftSpace + CGFloat(i + 1) * squareWidth + CGFloat(i) * middleSpace - squareWidth * 0.5, y: height * 0.5), radius: pointRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            context?.drawPath(using: .fill)
        }
    }
}

extension PasswordInputView: UIKeyInput {
    var hasText: Bool {
        return text.length > 0
    }
    
    func insertText(_ text: String) {
        if self.text.length < config.passwordNum {
            let cs = NSCharacterSet.init(charactersIn: "0123456789").inverted
            let string = text.components(separatedBy: cs).joined(separator: "")
            let basicTest = text == string
            if basicTest {
                self.text.append(text)
                delegate?.passwordInputViewDidChange(passwordInputView: self)
                if self.text.length == config.passwordNum {
                    delegate?.passwordInputViewCompleteInput(passwordInputView: self)
                }
                setNeedsDisplay()
            }
        }
    }
    
    func deleteBackward() {
        if text.length > 0 {
            text.deleteCharacters(in: NSRange(location: text.length - 1, length: 1))
            delegate?.passwordInputViewDidChange(passwordInputView: self)
        }
        delegate?.passwordInputViewDidDeleteBackward(passwordInputView: self)
        setNeedsDisplay()
    }
}


protocol PasswordInputViewDelegate {
    // 开始输入
    func passwordInputViewBeginInput(passwordInputView: PasswordInputView)
    // 输入改变
    func passwordInputViewDidChange(passwordInputView: PasswordInputView)
    // 点击删除
    func passwordInputViewDidDeleteBackward(passwordInputView: PasswordInputView)
    // 输入完成
    func passwordInputViewCompleteInput(passwordInputView: PasswordInputView)
    // 结束输入
    func passwordInputViewEndInput(passwordInputView: PasswordInputView)
}
