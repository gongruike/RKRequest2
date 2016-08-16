//
//  RKUtils.swift
//  NetworkDemo
//
//  Created by gongruike on 16/8/10.
//  Copyright © 2016年 gongruike. All rights reserved.
//

import UIKit

public class RKError {

    public static let RKErrorDomain = "cn.rk.request.error.domain"

    public static let IncorrectRequestTypeError: NSError = {
        //
        let userInfo = [
            NSLocalizedFailureReasonErrorKey: "Incorrect request type, please use a valid request type"
        ]
        return NSError(domain: RKErrorDomain, code: 10001, userInfo: userInfo)
    }()
    
    public static let EmptyResponseError: NSError = {
        //
        let userInfo = [
            NSLocalizedFailureReasonErrorKey: "Empty response"
        ]
        return NSError(domain: RKErrorDomain, code: 10002, userInfo: userInfo)
    }()
    
}
