import Foundation
import UIKit
import SwiftyJSON
import Alamofire


class RKBaseSwiftyJSONRequest<T>: RKRequest<SwiftyJSON.JSON, T> {
    
    override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override func prepareRequest(requestQueue: RKRequestQueue) {
        //
        self.requestQueue = requestQueue
        //
        let finalURL = NSURL(string: url.URLString, relativeToURL: requestQueue.configuration.baseURL)
        //
        self.aRequest = self.requestQueue?.session.request(method,
                                                           finalURL!,
                                                           parameters: parameters,
                                                           encoding: encoding,
                                                           headers: headers)
    }
    
    override func parseResponse() {
        self.aRequest?.responseSwiftyJSON({ response in
            
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}

class PostRequest: RKBaseSwiftyJSONRequest<[Post]> {
    // Custom init
    init(completionHandler: RKCompletionHandler?) {
        super.init(url: "stream/0/posts/stream/global",
                   completionHandler: completionHandler)
    }
    
    override func doParse() -> RKResult {
        if let response = aResponse {
            switch response.result {
            case .Success(let value):
                //
                let data = value["data"]
                let posts = data.map { Post(attribute: $1) }
                
                return RKResult.Success(posts)
            case .Failure(let error):
                return RKResult.Failure(error)
            }
        } else {
            return RKResult.Failure(GetIncorrectRequestTypeError())
        }
    }
}

class AvartarRequest: RKRequest<NSData, (NSIndexPath, UIImage)> {
    
    let indexPath: NSIndexPath
    
    init(indexPath: NSIndexPath, url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        self.indexPath = indexPath
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override func parseResponse() {
        self.aRequest?.responseData(completionHandler: { response in
            self.aResponse = response
            self.deliverResult()
        })
    }
    
    override func doParse() -> RKResult {
        return RKResult.Failure(GetIncorrectRequestTypeError())
    }
    
}



