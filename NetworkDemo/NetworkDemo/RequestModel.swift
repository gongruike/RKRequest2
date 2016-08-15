import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class RKBaseSwiftyJSONRequest<T>: RKRequest<SwiftyJSON.JSON, T> {
    
    override init(url: Alamofire.URLStringConvertible,
                  completionHandler: RKCompletionHandler?) {
        //
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override func parseData() {
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
    
    override func parseResponse(response: RKResponse) -> RKResult {
        //
        switch response.result {
        case .Success(let value):
            let data = value["data"]
            let posts = data.map { Post(attribute: $1) }
            return RKResult.Success(posts)
        case .Failure(let error):
            return RKResult.Failure(error)
        }
    }
    
}

struct PageListResult<T> {
    //
    let hasMore: Bool
    //
    let list: [T]
}

class BasePageListRequest<T>: RKBaseSwiftyJSONRequest<T> {
    
    let pageNumber: Int
    
    let pagecCount: Int
    
    init(pageNumber: Int,
         pagecCount: Int,
         url: Alamofire.URLStringConvertible,
         completionHandler: RKCompletionHandler?) {
        //
        self.pageNumber = pageNumber
        self.pagecCount = pagecCount
        //
        super.init(url: url, completionHandler: completionHandler)
    }
    
}

