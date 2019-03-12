//
//  SwipeCellController.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/19.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

class SwipeCellController: UIViewController {
    
    let cellHeight: CGFloat = 55.0
    var swipeTable: UITableView!
    
    let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile,those were such happy times and not so long ago,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling,how i wondered where they'd gone,but they're back again just like a long lost friend,all the songs i love so well,every shalala every wo'wo,still shines,every shing-a-ling-a-ling"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        swipeTable.reloadData()
        
        for (index, cell) in swipeTable.visibleCells.enumerated() {
            cell.frame.origin.y = swipeTable.bounds.size.height
            UIView.animate(withDuration: 0.8, delay: 0.02 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.frame.origin.y = 0
            }, completion: nil)
        }
    }
    
    func initSubviews() {
        title = "swipe列表"
        view.backgroundColor = UIColor.background

        swipeTable = UITableView(frame: view.frame)
        swipeTable.delegate = self
        swipeTable.dataSource = self
        swipeTable.backgroundColor = UIColor.background
        view.addSubview(swipeTable)
    }
    
}

extension SwipeCellController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyric.split(separator: ",").count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "font"
        let cell = UITableViewCell(style: .default, reuseIdentifier: indentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = String(lyric.split(separator: ",")[indexPath.row])
        cell.textLabel?.textColor = UIColor.mainText
        cell.isUserInteractionEnabled = true
        cell.frame.origin.y = self.cellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let likeAction = UITableViewRowAction(style: .normal, title: "👍") { action, index in
            print("like")
        }
        likeAction.backgroundColor = UIColor.green
        let dislikeAction = UITableViewRowAction(style: .normal, title: "👎") { action, index in
            print("dislike")
        }
        dislikeAction.backgroundColor = UIColor.red
        
        return [likeAction, dislikeAction]
    }
}
