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
    
    let user: User
    
    required init(attribute: JSONContainer) {
        postID = attribute["id"].uInt64Value
        text = attribute["text"].stringValue
        
        user = User(attribute: attribute["user"])
    }
    
}

class User: SwiftyType {
    
    let userID: UInt64
    let username: String
    
    required init(attribute: JSONContainer) {
        userID = attribute["id"].uInt64Value
        username = attribute["username"].stringValue
    }
}

