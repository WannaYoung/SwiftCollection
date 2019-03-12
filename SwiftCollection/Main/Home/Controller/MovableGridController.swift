//
//  MovableGridController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/28.
//  Copyright  © 2019 wannayoung. All rights reserved.
//

import UIKit

class MovableGridController: UIViewController {

    var startIndexPath = IndexPath()

    private let reuseIdentifier = "movable"
    private let itemPerRow: CGFloat = 4.0
    private let sectionInsets = UIEdgeInsets(top: 15.0, left: 25.0, bottom: 0, right: 25.0)
    
    var iconArray = ["QQ", "微信", "腾讯新闻", "什么值得买", "京东", "支付宝", "闲鱼", "淘宝", "优酷", "滴滴", "高德地图", "中国联通", "美团", "饿了么", "淘票票", "菜鸟裹裹"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(0)
            }
        }
    }
    
    func initSubviews() {
        title = "网格编辑"
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.background
    }
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.hex("ededed")
        $0.register(MovableGridCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        $0.addGestureRecognizer(longPressGesture)
    }
    
    lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressItem)).then {
        $0.minimumPressDuration = 0.5
    }
    
    @objc func longPressItem(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { break }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            break
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            break
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension MovableGridController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovableGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovableGridCell
        cell.titleLabel.text = iconArray[indexPath.item]
        cell.iconImage.image = UIImage(named: iconArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        iconArray.swapAt(sourceIndexPath.item, destinationIndexPath.item)
        collectionView.reloadData()
    }

}

extension MovableGridController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let widthPerItem = (UIDevice.width - paddingSpace) / itemPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
