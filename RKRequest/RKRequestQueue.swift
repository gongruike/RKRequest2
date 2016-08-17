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

public protocol RKPluginType {
    //
    func willSendRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
    //
    func didFinishRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
}

public protocol RKRequestQueueType {
    //
    var configuration: RKConfiguration { get }
    //
    func generateAlamofireRequest(request: RKBaseRequest) -> Alamofire.Request
    //
    func onSendRequest(request: RKBaseRequest)
    //
    func onFinishRequest(request: RKBaseRequest)
}

public class RKRequestQueue: RKRequestQueueType {
    //
    public let session: Alamofire.Manager
    //
    public let configuration: RKConfiguration
    //
    public var plugins: [RKPluginType] = []
    
    public init(configuration: RKConfiguration) {
        //
        self.configuration = configuration
        //
        self.session = Alamofire.Manager(configuration: configuration.configuration,
                                         delegate: Alamofire.Manager.SessionDelegate(),
                                         serverTrustPolicyManager: configuration.trustPolicyManager)
        // Important
        self.session.startRequestsImmediately = false
        //
        self.plugins.append(RKNetworkActivityPlugin())
    }
    
    public func startRequest(request: RKBaseRequest) {
        //
        request.prepareRequest(self)
        //
        request.validate()
        //
        request.start()
    }
    
    //
    public func generateAlamofireRequest(request: RKBaseRequest) -> Alamofire.Request {
        //
        return session.request(request.method,
                               request.url,
                               parameters: request.parameters,
                               encoding: request.encoding,
                               headers: request.headers)
    }
    
    //
    public func onSendRequest(request: RKBaseRequest) {
        //
        dispatch_async(dispatch_get_main_queue()) {
            //
            self.plugins.forEach { plugin in
                //
                plugin.willSendRequest(self, request: request)
            }
        }
    }
    
    //
    public func onFinishRequest(request: RKBaseRequest) {
        //
        dispatch_async(dispatch_get_main_queue()) {
            //
            self.plugins.forEach { plugin in
                //
                plugin.didFinishRequest(self, request: request)
            }
        }
    }
    
}
