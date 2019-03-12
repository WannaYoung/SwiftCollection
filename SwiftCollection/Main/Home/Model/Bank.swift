//
//  Bank.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/3/1.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import HandyJSON

class Banks: HandyJSON {
    var data: [Bank] = []
    
    required init() {}
}

class Bank: HandyJSON {
    var id = 0
    var name = ""
    var code = ""
    
    required init() {}
}
