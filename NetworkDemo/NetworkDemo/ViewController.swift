import UIKit

class ViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getPost()
        
    }
    
    func getPost() {
        //
        let request = PostRequest { response in
            switch response {
            case .Success(let result):
                // Success
                self.posts.appendContentsOf(result)
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
        HTTPClient.sharedInstance.startRequest(request)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCellIdentifier",
                                                               forIndexPath: indexPath) as! PostTableViewCell
        return cell
    }

}


