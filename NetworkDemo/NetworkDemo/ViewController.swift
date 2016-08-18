import UIKit

class ViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item = UIBarButtonItem(barButtonSystemItem: .Refresh,
                                   target: self,
                                   action: #selector(onRefreshBarButtonItemClicked(_:)))
        navigationItem.rightBarButtonItem = item
        
        getPost()
    }
    
    func onRefreshBarButtonItemClicked(sender: UIBarButtonItem)  {
        //
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
        cell.configureCell(posts[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}


