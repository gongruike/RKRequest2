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
    This is a abstract generic class, use by subclassing it.
 */
public class RKRequest<ResponseType, TargetType>: RKBaseRequest {
    //
    public typealias RKResult = Alamofire.Result<TargetType, NSError>
    //
    public typealias RKResponse = Alamofire.Response<ResponseType, NSError>
    //
    public typealias RKCompletionHandler = RKResult -> Void
    
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
    
    public override func start() {
        //
        super.start()
        //
        parseData()
    }
    
    public override func cancel() {
        //
        super.cancel()
        //
        deliverResult()
    }
    
    /*
        CustomStringConvertible
     */
    public override var description: String {
        return aResponse?.description ?? aRequest?.description ?? url.URLString
    }
    
    /*
        CustomDebugStringConvertible
     */
    public override var debugDescription: String {
        return aResponse?.debugDescription ?? aRequest.debugDescription ?? url.URLString
    }
    
    /*
        Parse the data from server into ResponseType，
        ResponseType can be JSON, String, NSData, SwiftyJSON.
     */
    internal func parseData() {}
    
    /*
        Parse the aResponse to the final TargetType or generate a error
     */
    internal func parseResponse(response: RKResponse) -> RKResult {
        //
        return RKResult.Failure(RKError.IncorrectRequestTypeError)
    }
    
    /*
        Deliver result or error in the main thread
     */
    internal func deliverResult() {
        //
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //
            let result: RKResult
            if let response = self.aResponse {
                result = self.parseResponse(response)
            } else {
                result = RKResult.Failure(RKError.EmptyResponseError)
            }
            //
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                //
                self.completionHandler?(result)
            }
        }
    }
    
}

