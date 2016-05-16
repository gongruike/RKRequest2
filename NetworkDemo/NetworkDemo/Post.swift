//
//  Post.swift
//  NetworkDemo
//
//  Created by gongruike on 16/5/16.
//  Copyright © 2016年 gongruike. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias JSONContainer = SwiftyJSON.JSON

protocol SwiftyType {
    init(attribute: JSONContainer)
}

class Post: SwiftyType {
    
    let postID: UInt64
    let text: String
    
    required init(attribute: JSONContainer) {
        postID = attribute["id"].uInt64Value
        text = attribute["text"].stringValue
    }
    
}


class User: SwiftyType {
    
    let userID: String
    let username: String
    // avatar_image.url
    required init(attribute: JSONContainer) {
        userID = attribute["id"].stringValue
        username = attribute["username"].stringValue
    }
}
