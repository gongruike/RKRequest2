import UIKit
import Alamofire

public class RKRequestQueue {
    //
    public static let sharedQueue: RKRequestQueue = RKRequestQueue()
    //
    public let session: Alamofire.Manager
    
    public var plugins: [PluginType] = []
    
    public class func defaultURLSessionConfiguration() -> NSURLSessionConfiguration {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        configuration.HTTPShouldUsePipelining = false
        configuration.HTTPShouldSetCookies = false
        
        configuration.requestCachePolicy = .UseProtocolCachePolicy
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForResource = 15
        
        return configuration
    }
    
    public init(configuration: NSURLSessionConfiguration = RKRequestQueue.defaultURLSessionConfiguration()) {
        session = Alamofire.Manager(configuration: configuration)
        // Important
        session.startRequestsImmediately = false
    }
    
    public func startRequest(request: RKBaseRequest) {
        //
        request.prepareRequest(self)
        //
        request.startRequest()
        //
        request.aRequest?.response(completionHandler: { (_, _, _, _) in
            //
            self.finishRequest(request)
        })
        //
        request.parseResponse()
        //
        plugins.forEach { plugin in
            plugin.willSendRequest(self, request: request)
        }
    }
    
    public func finishRequest(request: RKBaseRequest) {
        //
        plugins.forEach { plugin in
            plugin.didFinishedRequest(self, request: request)
        }
    }
    
}

public protocol PluginType {
    func willSendRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
    func didFinishedRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
}
