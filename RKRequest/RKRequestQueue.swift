import UIKit
import Alamofire

public protocol PluginType {
    func willSendRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
    func didFinishedRequest(requestQueue: RKRequestQueue, request: RKBaseRequest)
}

public class RKRequestQueue {
    //
    public let session: Alamofire.Manager
    
    public let configuration: RKConfiguration
    
    public var plugins: [PluginType] = []
    
    //
    public init(configuration: RKConfiguration) {
        
        self.configuration = configuration
        
        session = Alamofire.Manager(configuration: configuration.configuration,
                                    delegate: Alamofire.Manager.SessionDelegate(),
                                    serverTrustPolicyManager: configuration.trustPolicyManager)
        // Important
        session.startRequestsImmediately = false
        
        //
        plugins.append(RKNetworkActivityPlugin())

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


