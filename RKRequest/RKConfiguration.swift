//
//  RKConfig.swift
//  NetworkDemo
//
//  Created by gongruike on 16/5/16.
//  Copyright © 2016年 gongruike. All rights reserved.
//

import UIKit
import Alamofire

public class RKConfiguration {

    public let baseURL: Alamofire.URLStringConvertible
    
    public let configuration: NSURLSessionConfiguration
    
    public let trustPolicyManager: Alamofire.ServerTrustPolicyManager?
    
    public init(baseURL: Alamofire.URLStringConvertible,
                configuration: NSURLSessionConfiguration = RKConfiguration.defaultURLSessionConfiguration(),
                trustPolicyManager: Alamofire.ServerTrustPolicyManager? = nil) {
        //
        self.baseURL = baseURL
        self.configuration = configuration
        self.trustPolicyManager = trustPolicyManager
    }
    
    public class func defaultURLSessionConfiguration() -> NSURLSessionConfiguration {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        configuration.HTTPShouldUsePipelining = false
        configuration.HTTPShouldSetCookies = false
        
        configuration.requestCachePolicy = .UseProtocolCachePolicy
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForResource = 15
        
        return configuration
    }
    
}
