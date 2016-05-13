import Foundation
import UIKit

class RKNetworkActivityPlugin: PluginType {
    
    var requestCount: Int = 0
    
    func increment() {
        requestCount += 1
        if requestCount > 0 {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
    }
    
    func decrement() {
        requestCount -= 1
        if requestCount == 0 {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    //
    func willSendRequest(requestQueue: RKRequestQueue, request: RKBaseRequest) {
        increment()
    }
    
    func didFinishedRequest(requestQueue: RKRequestQueue, request: RKBaseRequest) {
        decrement()
    }
}

