import Foundation

class HTTPClient {
    
    private let requestQueue: RKRequestQueue
    
    static let sharedInstance: HTTPClient = HTTPClient()
    
    init() {
        //
        let url = NSURL(string: "https://api.app.net/")
        //
        let configuration = RKConfiguration(baseURL: url)
        //
        requestQueue = RKRequestQueue(configuration: configuration)
    }
    
    func startRequest(request: RKBaseRequest) {
        //
        requestQueue.addRequest(request)
    }
    
}

