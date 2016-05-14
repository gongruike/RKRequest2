import Foundation

class HTTPClient {
    
    private let requestQueue: RKRequestQueue
    
    static let sharedInstance: HTTPClient = HTTPClient()
    
    init() {
        requestQueue = RKRequestQueue()
    }
    
    func startRequest(request: RKBaseRequest) {
        //
        requestQueue.startRequest(request)
    }
    
    //
    
}

class A {

}

class B: A {
    init(url: String) {
        
    }
}

class C: B {
    
}

class D: C {
    
}

let c = D(url: "")
