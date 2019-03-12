//
//  ScrollNumberView.swift
//  ScrollNumberView
//
//  Created by 王洋 on 2018/8/23.
//  Copyright © 2018年 王洋. All rights reserved.
//

import UIKit

public struct ScrollNumberStytle {
    public var scrollLine: Int = 5
    public var isScrollUp = true
    public var duration = 1.0
    public var durationOffset = 0.1
    public var textColor = UIColor.darkGray
    public var font = UIFont.boldSystemFont(ofSize: 40)
    
    public init() { }
}

class ScrollNumberView: UIView {
    
    var style: ScrollNumberStytle = ScrollNumberStytle()
    
    public var number: NSNumber {
        didSet {
            for numberLable in numberLabelArray {
                numberLable.removeFromSuperview()
            }
            numberLabelArray.removeAll()
            separateNumber()
        }
    }
    
    public var numberString: String {
        get {
            return number == 0 ? "" : self.number.stringValue
        }
    }

    override init(frame: CGRect) {
        number = 0
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var exceptAnimIndexSet: NSMutableSet = {
        var tempSet = NSMutableSet()
        return tempSet
    }()
    
    lazy var numberLabelArray: [UILabel] = {
        var tempArray: [UILabel] = []
        return tempArray
    }()
    
    lazy var scrollLineNum: Int = {
        return style.scrollLine+1
    }()
    
    lazy var oneLineHeight: CGFloat = {
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        let attributes = [NSAttributedString.Key.font: style.font, NSAttributedString.Key.paragraphStyle: paragraph]
        let string = "8"
        let size = string.size(withAttributes: attributes)
        return CGFloat(ceilf(Float(size.height)))
    }()
    
    lazy var maxY: CGFloat = {
        return oneLineHeight * CGFloat(scrollLineNum) - oneLineHeight;
    }()
    

    func separateNumber() {
        for i in 0..<numberString.count {
            numberLabelArray.append(createLabelWithIndex(index: i))
        }
    }
    
    func createLabelWithIndex(index: Int) -> UILabel {
        let singleWidth = frame.size.width/CGFloat(numberString.count)
        let numberLabel = UILabel(frame: CGRect(x: CGFloat(index)*singleWidth, y: style.isScrollUp ? 0 : -maxY, width: singleWidth, height: oneLineHeight * CGFloat(scrollLineNum)))
        addSubview(numberLabel)
        numberLabel.font = style.font
        numberLabel.textColor = style.textColor;
        numberLabel.backgroundColor = UIColor.clear
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 0
        numberLabel.lineBreakMode = .byClipping
        let startIndex = numberString.index(numberString.startIndex, offsetBy:index)
        let endIndex = numberString.index(startIndex, offsetBy:1)
        numberLabel.text = buildText(text: numberString.substring(with: startIndex..<endIndex))
        return numberLabel
    }
    
    func buildText(text: String) -> String {
        var string = text
        for _ in 0..<scrollLineNum-2 {
            string.append("\n\(arc4random() % 10)")
        }
        string.append("\n\(text)")
        return string
    }
    func startAnimation() {
        let animationDuration: CFTimeInterval = style.duration-Double(numberLabelArray.count)*style.durationOffset
        var offset: CFTimeInterval = 0
        for i in 0..<numberLabelArray.count {
            if exceptAnimIndexSet.contains(NSNumber(value: i)) {
                continue
            }
            let numberLable = numberLabelArray[i]
            numberLable.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            let animation = CABasicAnimation(keyPath: "position.y")
            animation.duration = animationDuration+offset
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.fromValue = style.isScrollUp ? 0 : -maxY
            animation.toValue = style.isScrollUp ? -maxY : 0
            numberLable.layer.add(animation, forKey: "SCScrollNumberViewAnimation")
            offset += style.durationOffset
        }
    }
}
