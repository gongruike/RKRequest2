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
public class RKBaseRequest: Hashable {
    
    public var url: Alamofire.URLStringConvertible
    
    public var method: Alamofire.Method = .GET
    
    public var headers: [String: String] = [:]
    
    public var parameters: [String: AnyObject] = [:]
    
    public var encoding: Alamofire.ParameterEncoding = .URL
    
    public var requestQueue: RKRequestQueue?
    
    public var aRequest: Alamofire.Request?
    
    public init(url: Alamofire.URLStringConvertible) {
        self.url = url
    }
    
    /*
        Bind requestQueue & Generate aRequest
     */
    public func prepareRequest(requestQueue: RKRequestQueue) {}
    
    /*
        Must call prepareRequest(_) before startRequest()
     */
    public func startRequest() {}
    
    /*
        Cancel request
     */
    public func cancelRequest() {}
    
    /*
        HashValue
     */
    public var hashValue: Int { return url.URLString.hashValue ^ method.rawValue.hashValue }
    
}

public func ==(lhs: RKBaseRequest, rhs: RKBaseRequest) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
