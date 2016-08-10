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
        let finalURL = NSURL(string: url.URLString, relativeToURL: requestQueue.configuration.baseURL)
        //
        self.requestQueue = requestQueue
        //
        aRequest = requestQueue.session.request(method,
                                                finalURL!,
                                                parameters: parameters,
                                                encoding: encoding,
                                                headers: headers)
    }
    
    override func parseResponse() {
        //
        aRequest?.responseSwiftyJSON({ response in
            
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}

class PostRequest: RKBaseSwiftyJSONRequest<[Post]> {
    //
    init(completionHandler: RKCompletionHandler?) {
        super.init(url: "stream/0/posts/stream/global",
                   completionHandler: completionHandler)
    }
    
    override func parseResult(response: RKResponse) -> RKResult {
        //
        switch response.result {
        case .Success(let value):
            //
            let data = value["data"]
            let posts = data.map { Post(attribute: $1) }
            return RKResult.Success(posts)
        case .Failure(let error):
            return RKResult.Failure(error)
        }
    }
    
}

class BaseListRequest<T>: RKBaseSwiftyJSONRequest<T> {
    
    let page: Int
    
    let count: Int
    
    init(page: Int,
         count: Int,
         url: Alamofire.URLStringConvertible,
         completionHandler: RKCompletionHandler?) {
        //
        self.page = page
        self.count = count
        //
        super.init(url: url, completionHandler: completionHandler)
    }
    
}


class AvartarRequest: RKRequest<NSData, (NSIndexPath, UIImage)> {
    
    let indexPath: NSIndexPath
    
    init(indexPath: NSIndexPath,
         url: Alamofire.URLStringConvertible,
         completionHandler: RKCompletionHandler?) {
        //
        self.indexPath = indexPath
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override func parseResponse() {
        aRequest?.responseData(completionHandler: { response in
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}
