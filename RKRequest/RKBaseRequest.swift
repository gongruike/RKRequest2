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

import Foundation
import Alamofire

/*
    This is the base request class.
 */
public class RKBaseRequest: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    
    public var url: Alamofire.URLStringConvertible
    
    public var method: Alamofire.Method = .GET
    
    public var headers: [String: String] = [:]
    
    public var parameters: [String: AnyObject] = [:]
    
    public var encoding: Alamofire.ParameterEncoding = .URL
    
    public var acceptableStatusCodes: Range<Int> = 200..<300
    
    public var acceptableContentTypes: [String] = ["*/*"]
        
    public var requestQueue: RKRequestQueueType?
    
    public var aRequest: Alamofire.Request?
    
    public init(url: Alamofire.URLStringConvertible) {
        self.url = url
    }
    
    /*
        Bind requestQueue & Generate aRequest
     */
    public func prepareRequest(requestQueue: RKRequestQueueType) {
        //
        self.requestQueue = requestQueue
        //
        url = NSURL(string: url.URLString, relativeToURL: requestQueue.configuration.baseURL)!
        //
        aRequest = requestQueue.generateAlamofireRequest(self)
    }
    
    /*
        Must call prepareRequest(_) before startRequest()
     */
    public func start() {
        //
        aRequest?.resume()
        //
        requestQueue?.onSendRequest(self)
    }
    
    /*
        Cancel request
     */
    public func cancel() {
        //
        aRequest?.cancel()
    }
    
    /*
        Validate response
     */
    public func validate() {
        //
        aRequest?.validate(statusCode: acceptableStatusCodes).validate(contentType: acceptableContentTypes)
    }
    
    /*
        HashValue
     */
    public var hashValue: Int {
        //
        return url.URLString.hashValue ^ method.rawValue.hashValue
    }
    
    /*
        CustomStringConvertible
     */
    public var description: String {
        //
        return aRequest?.description ?? url.URLString
    }
    
    /*
        CustomDebugStringConvertible
     */
    public var debugDescription: String {
        //
        return aRequest?.debugDescription ?? url.URLString
    }
    
}

public func ==(lhs: RKBaseRequest, rhs: RKBaseRequest) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
