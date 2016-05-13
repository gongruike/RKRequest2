import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let request = RKBaseSwiftyJSONRequest<Bool>(url: "https://api.app.net/stream/0/posts/stream/global") { response in
            switch response {
            case .Success(let result):
                print(result)
            case .Failure(let error):
                print(error)
            }
        }
        HTTPClient.sharedInstance.startRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

