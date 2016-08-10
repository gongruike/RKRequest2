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

/*
    This is just a abstract class, use it by subclassing it.
 */
public class RKRequest<ResponseType, TargetType>: RKBaseRequest {
    //
    public typealias RKCompletionHandler = RKResult -> Void
    //
    public typealias RKResult = Alamofire.Result<TargetType, NSError>
    //
    public typealias RKResponse = Alamofire.Response<ResponseType, NSError>

    //
    public var aResponse: RKResponse?
    //
    public var completionHandler: RKCompletionHandler?
    
    public init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        //
        self.completionHandler = completionHandler
        //
        super.init(url: url)
    }
    
    public override func prepareRequest(requestQueue: RKRequestQueue) {
        //
        self.requestQueue = requestQueue
        //
        aRequest = requestQueue.session.request(method,
                                                url,
                                                parameters: parameters,
                                                encoding: encoding,
                                                headers: headers)
    }
    
    public override func startRequest() {
        //
        aRequest?.resume()
        //
        parseResponse()
    }
    
    public override func cancelRequest() {
        //
        aRequest?.cancel()
        //
        deliverResult()
    }
    
    /*
         Parse the response from server
     */
    public func parseResponse() {
        // Parse the data from server into ResponseType 
        // ResponseType can be JSON, String, NSData, SwiftyJSON.
    }
    
    /*
         Parse the aResponse to the final TargetType or generate a error
     */
    public func parseResult(response: RKResponse) -> RKResult {
        //
        return RKResult.Failure(RKError.IncorrectRequestTypeError)
    }
    
    /*
         Deliver result or error in the main thread
     */
    public func deliverResult() {
        //
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //
            let result: RKResult
            if let response = self.aResponse {
                result = self.parseResult(response)
            } else {
                result = RKResult.Failure(RKError.IncorrectRequestTypeError)
            }
            //
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                //
                self.completionHandler?(result)
            }
        }
    }
    
}

