// The MIT License (MIT)
//
// Copyright (c) 2016 Ruike Gong
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import Alamofire

public enum RKPrioritization {
    //
    case FIFO
    //
    case LIFO
}

public class RKConfiguration {

    public var baseURL: NSURL?
    //
    public let maximumActiveRequestCount: Int
    //
    public let prioritization: RKPrioritization
    //
    public let configuration: NSURLSessionConfiguration
    //
    public let trustPolicyManager: Alamofire.ServerTrustPolicyManager?
    
    public init(baseURL: NSURL?,
                maximumActiveRequestCount: Int = 3,
                prioritization: RKPrioritization = .FIFO,
                configuration: NSURLSessionConfiguration = RKConfiguration.defaultURLSessionConfiguration(),
                trustPolicyManager: Alamofire.ServerTrustPolicyManager? = nil) {
        //
        self.baseURL                    = baseURL
        self.maximumActiveRequestCount  = maximumActiveRequestCount
        self.prioritization             = prioritization
        self.configuration              = configuration
        self.trustPolicyManager         = trustPolicyManager
    }
    
    public class func defaultURLSessionConfiguration() -> NSURLSessionConfiguration {
        //
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.HTTPAdditionalHeaders         = Alamofire.Manager.defaultHTTPHeaders
        configuration.HTTPShouldUsePipelining       = true
        configuration.HTTPShouldSetCookies          = false
        
        configuration.requestCachePolicy            = .UseProtocolCachePolicy
        configuration.allowsCellularAccess          = true
        configuration.timeoutIntervalForResource    = 15
        
        configuration.URLCache = defaultURLCache()
        
        return configuration
    }
    
    public class func defaultURLCache() -> NSURLCache {
        //
        return NSURLCache(
            memoryCapacity: 20 * 1024 * 1024, // 20 MB
            diskCapacity: 150 * 1024 * 1024,  // 150 MB
            diskPath: "cn.rk.request.url.cache"
        )
    }
    
}
