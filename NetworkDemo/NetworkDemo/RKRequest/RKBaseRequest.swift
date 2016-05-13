import Foundation
import Alamofire

/*
     In Swift collection types like Array or Set can't hold the instancs of a generic class,
     so I hava to extra a superclass.
 */
public class RKBaseRequest: Hashable {
    
    public let tag: Int = random()
    
    public var url: Alamofire.URLStringConvertible
    
    public var method: Alamofire.Method = .GET
    
    public var headers: [String: String] = [:]
    
    public var parameters: [String: AnyObject] = [:]
    
    public var encoding: Alamofire.ParameterEncoding = .URL
    
    public var requestQueue: RKRequestQueue?
    
    public var aRequest: Alamofire.Request?
    
    init(url: Alamofire.URLStringConvertible) {
        self.url = url
    }
    
    /*
        Bind requestQueue & Generate aRequest
     */
    public func prepareRequest(requestQueue: RKRequestQueue) {}
    
    /*
        Start request
     */
    public func startRequest() {}
    
    /*
        Cancel request
     */
    public func cancelRequest() {}
    
    /*
        Parse the response from server
     */
    public func parseResponse() {}
    
    /*
        Deliver result or error
     */
    public func deliverResult() {}
    
    /*
        HashValue
        TBD
        此处需要优化
     */
    public var hashValue: Int { return url.URLString.hashValue + method.rawValue.hashValue + tag.hashValue }
}

public func ==(lhs: RKBaseRequest, rhs: RKBaseRequest) -> Bool {
    return lhs.hashValue == rhs.hashValue
}


