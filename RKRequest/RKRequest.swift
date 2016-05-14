import UIKit
import Alamofire

/*
    This class is just a abstract class, use it by subclassing it.
 */
public class RKRequest<ResponseType, TargetType>: RKBaseRequest {
    //
    public typealias RKResult = Alamofire.Result<TargetType, NSError>
    //
    public typealias RKCompletionHandler = RKResult -> Void

    //
    public var aResponse: Alamofire.Response<ResponseType, NSError>?
    //
    public var completionHandler: RKCompletionHandler?
    
    public init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        //
        self.completionHandler = completionHandler
        //
        super.init(url: url)
    }
    
    /*
        Parse the aResponse to the final TargetType or generate a error
     */
    public func doParse() -> RKResult {
        return RKResult.Failure(GetIncorrectRequestTypeError())
    }
    
    public override func prepareRequest(requestQueue: RKRequestQueue) {
        //
        self.requestQueue = requestQueue
        //
        self.aRequest = self.requestQueue?.session.request(method, url,
                                                           parameters: parameters,
                                                           encoding: encoding,
                                                           headers: headers)
    }
    
    public override func startRequest() {
        //
        self.aRequest?.resume()
    }
    
    public override func cancelRequest() {
        //
        self.aRequest?.cancel()
    }
    
    public override func parseResponse() {
        // Parse the data from server into ResponseType 
        // ResponseType can be JSON, String, NSData using methods in Alamofire.ResponseSerialization 
        // Then assign value to aResponse
    }
    
    public override func deliverResult() {
        //
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //
            let result = self.doParse()
            //
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                //
                self.completionHandler?(result)
            }
        }
    }
    
}

// Error
private let RKErrorDomain = "cn.rk.request.error.domain"

func GetIncorrectRequestTypeError() -> NSError {
    let userInfo = [NSLocalizedFailureReasonErrorKey: "Please use a concerate request class"]
    return NSError(domain: RKErrorDomain, code: 10001, userInfo: userInfo)
}

