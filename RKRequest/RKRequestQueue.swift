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

public protocol PluginType {
    func willSendRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
    func didFinishedRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
}

public class RKRequestQueue {
    //
    public let session: Alamofire.Manager
    
    public let configuration: RKConfiguration
    
    public var plugins: [PluginType] = []
    
    //
    public init(configuration: RKConfiguration) {
        
        self.configuration = configuration
        
        session = Alamofire.Manager(configuration: configuration.configuration,
                                    delegate: Alamofire.Manager.SessionDelegate(),
                                    serverTrustPolicyManager: configuration.trustPolicyManager)
        // Important
        session.startRequestsImmediately = false
        
        //
        plugins.append(RKNetworkActivityPlugin())

    }
    
    public func startRequest(request: RKBaseRequest) {
        //
        request.prepareRequest(self)
        //
        request.startRequest()
        //
        request.parseResponse()
        //
        request.aRequest?.response(completionHandler: { (_, _, _, _) in
            //
            self.finishRequest(request)
        })
        //
        plugins.forEach { plugin in
            plugin.willSendRequest(self, request: request)
        }
    }
    
    public func finishRequest(request: RKBaseRequest) {
        //
        plugins.forEach { plugin in
            plugin.didFinishedRequest(self, request: request)
        }
    }
    
}


