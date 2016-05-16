import Foundation

class HTTPClient {
    
    private let requestQueue: RKRequestQueue
    
    static let sharedInstance: HTTPClient = HTTPClient()
    
    init() {
        
        let configuration = RKConfiguration(baseURLString: "https://api.app.net/")
        
        requestQueue = RKRequestQueue(configuration: configuration)
    }
    
    func startRequest(request: RKBaseRequest) {
        //
        requestQueue.startRequest(request)
    }
    
    //
    
}

