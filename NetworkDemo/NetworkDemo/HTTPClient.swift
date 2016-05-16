import Foundation

class HTTPClient {
    
    private let requestQueue: RKRequestQueue
    
    static let sharedInstance: HTTPClient = HTTPClient()
    
    init() {
        
        let configuration = RKConfiguration(baseURL: "")
        
        requestQueue = RKRequestQueue(configuration: configuration)
    }
    
    func startRequest(request: RKBaseRequest) {
        //
        requestQueue.startRequest(request)
    }
    
    //
    
}

