//
//  WaterflowController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/15.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import Kingfisher

class WaterflowController: UIViewController {

    var currentPage = 1
    var unsplashSearch = UnsplashSearch()
    let queryKeys = ["love", "cat", "beach", "animal", "pretty", "wedding"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getUnsplashImages(isRefresh: true)
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
        title = "瀑布流"
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.background
//        collectionView.refreshHeader = refreshHeader
//        collectionView.refreshFooter = refreshFooter
    }
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterfolw).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.hex("ededed")
        $0.register(WaterflowCell.self, forCellWithReuseIdentifier: "waterflow")
    }

    lazy var waterfolw = WaterflowLayout().then {
        $0.colNum = 2
        $0.interSpace = 10
        $0.delegate = self
        $0.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.sectionInset = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
    }
    
    lazy var refreshHeader = RefreshNativeHeader(refreshHandler: {
            self.getUnsplashImages(isRefresh: true)
    }).then {
        $0.stateLabel?.isHidden = true
        $0.lastUpdatedTimeLabel?.isHidden = true
    }
    
    lazy var refreshFooter = RefreshBackNativeFooter(refreshHandler: {
            self.getUnsplashImages(isRefresh: false)
    }).then {
        $0.stateLabel?.isHidden = true
    }
    
    func getUnsplashImages(isRefresh: Bool) {
        NetworkManager.share.getDataWith(path: searchApi, parama: ["client_id": userKey, "query": queryKeys.randomElement()!, "page": isRefresh ? "1" : "\(currentPage+1)", "per_page": "10"], successHandler: { (search: UnsplashSearch) in
            if isRefresh {
                self.currentPage = 1
                self.unsplashSearch = search
            } else {
                if search.results.count > 0 {
                    self.currentPage = self.currentPage+1
                    self.unsplashSearch.results.append(contentsOf: search.results)
                } else {
                    print("no more data")
                }
            }
            UIView.animate(withDuration: 0.00001, animations: {
                self.collectionView.reloadData()
            }, completion: { (success) in
                self.refreshHeader.endRefreshing()
                self.refreshFooter.endRefreshing()
            })
        })
    }
}

extension WaterflowController: WaterFlowLayoutDelegate {
    func itemHeightLayOut(layout: WaterflowLayout, indexPath: IndexPath) -> CGFloat {
        return getImageHeight(result: unsplashSearch.results[indexPath.row], waterFlow: layout)+50.0
    }
    
    func getImageHeight(result: SearchResult, waterFlow: WaterflowLayout) -> CGFloat {
        let multiple = (UIDevice.width - waterFlow.interSpace * CGFloat(waterFlow.colNum + 1)) / CGFloat(waterFlow.colNum) / CGFloat(result.width)
        let itemHeight = CGFloat(result.height) * multiple
        return itemHeight
    }
}

extension WaterflowController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unsplashSearch.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let result = unsplashSearch.results[indexPath.row]
        let cell: WaterflowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "waterflow", for: indexPath) as! WaterflowCell
        
        let endIndex = result.created_at.index(result.created_at.startIndex, offsetBy: 10)
        cell.unsplashImage.kf.setImage(with: URL(string: result.urls.small))
        cell.avatorImage.kf.setImage(with: URL(string: result.user.profile_image.medium))
        cell.nameLabel.text = result.user.name
        cell.dateLabel.text = String(result.created_at[result.created_at.startIndex..<endIndex])
        
        return cell
    }
}

extension WaterflowController: UICollectionViewDelegate {
    
}
