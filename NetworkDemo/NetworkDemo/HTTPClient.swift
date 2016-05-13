import Foundation

class HTTPClient {
    
    private let requestQueue: RKRequestQueue = RKRequestQueue.sharedQueue
    
    static let sharedInstance: HTTPClient = HTTPClient()
    
    func startRequest(request: RKBaseRequest) {
        //
        requestQueue.startRequest(request)
    }
    
}

