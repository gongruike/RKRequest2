import UIKit
import Alamofire

public class RKTypeRequest<T>: RKRequest<T, T> {
    
    public override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    public override func doParse() -> RKResult {
        if let response = aResponse {
            switch response.result {
            case .Success(let value):
                return RKResult.Success(value)
            case .Failure(let error):
                return RKResult.Failure(error)
            }
        } else {
            return RKResult.Failure(GetIncorrectRequestTypeError())
        }
    }
}

/*
    字符串请求
 */
public class RKStringRequest: RKTypeRequest<String> {
    
    public override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    public override func parseResponse() {
        aRequest?.responseString(completionHandler: { response -> Void in
            
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}

/*
    NSData请求
 */
public class RKDataRequest: RKTypeRequest<NSData> {
    
    public override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    public override func parseResponse() {
        aRequest?.responseData(completionHandler: { response in
            
            self.aResponse = response
            self.deliverResult()
        })
    }

}

/*
    普通JSON请求
 */
public class RKJSONRequest: RKTypeRequest<AnyObject> {
    
    public override init(url: Alamofire.URLStringConvertible, completionHandler: RKCompletionHandler?) {
        super.init(url: url, completionHandler: completionHandler)
    }
    
    override public func parseResponse() {
        aRequest?.responseJSON(completionHandler: { response -> Void in
            
            self.aResponse = response
            self.deliverResult()
        })
    }

}

