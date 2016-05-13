//
//  RKError.swift
//  RKRequest
//
//  Created by gongruike on 16/5/4.
//  Copyright © 2016年 TiUP. All rights reserved.
//

import Foundation
import Alamofire

public struct RKError {
    
    // Error Domain
    public static let RKErrorDomain = "cn.rk.request.error.domain"
    
    // Error Code
    public enum RKErrorCode: Int {
        case IncorrectRequestType
    }
    
    public static func errorWithCode(code: RKErrorCode, failureReason: String) -> NSError {
        return errorWithCode(code.rawValue, failureReason: failureReason)
    }

    public static func errorWithCode(code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: RKErrorDomain, code: code, userInfo: userInfo)
    }
    
}
