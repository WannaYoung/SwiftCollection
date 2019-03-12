//
//  UnsplashSearch.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/15.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit
import HandyJSON

class UnsplashSearch: HandyJSON {
    var total = 0
    var total_pages = 0
    var results: [SearchResult] = []
    
    required init() {}
}

class SearchResult: HandyJSON {
    var id = ""
    var width = 0
    var height = 0
    var urls = PhotoUrls()
    var created_at = ""
    var description = ""
    var user: UserInfo = UserInfo()
    
    required init() {}
}

class PhotoUrls: HandyJSON {
    var raw = ""
    var full = ""
    var regular = ""
    var small = ""
    var thumb = ""
    
    required init() {}
}

class UserInfo: HandyJSON {
    var name = ""
    var profile_image: ProfileImage = ProfileImage()
    
    required init() {}
}

class ProfileImage: HandyJSON {
    var small = ""
    var medium = ""
    var large = ""
    
    required init() {}
}
