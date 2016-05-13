import Foundation
import SwiftyJSON
import Alamofire

class RKBaseSwiftyJSONRequest<T>: RKRequest<SwiftyJSON.JSON, T> {
    
    override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override func parseResponse() {
        self.aRequest?.responseSwiftyJSON({ response in
            
            print(response.debugDescription)
            
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}

class PostRequest: RKBaseSwiftyJSONRequest<[Post]> {
    
}


class Post {
    
}

