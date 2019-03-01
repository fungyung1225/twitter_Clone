//
//  PhotoViewController.swift
//  ex_Tumblr
//
//  Created by Fung on 2/15/19.
//  Copyright © 2019 fungyung. All rights reserved.
//

import UIKit
//import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250 // set to cell height since we are not using auto-layout
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                self.tableView.reloadData() // refreshes after our network data comes back in
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        //cell.textLabel!.text = "row: \(indexPath.row)"h
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row] // possible to get a nil value
        if let unwarappedPhotos = post["photos"] as? [[String:Any]]{
            let photo = unwarappedPhotos[0]
            let originalSize = photo["original_size"] as! [String:Any]
            let urlString = originalSize["ur"] as! String
            let url = URL(string: <#T##String#>)
            
            
        }
//        let post = posts[indexPath.row] // possible to get a nil value
//        if let unwrappedPhotos = post["photos"] as? [[String: Any]]{
//            // Unwraps post. This code block only runs if value != nil
//            let photo = unwrappedPhotos[0]
//            let originalSize = photo["original_size"] as! [String: Any]
//            let urlString = originalSize["url"] as! String
//            let url = URL(string: urlString)
//
//            cell.posterView.af_setImage(withURL: url!)
//        }

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    //wf
//    //1) Connect tableiew outlet
//    //2) Add UITableView DataSource, UITableViewDelegate
//    //3) tableView.dataSource = self
//         //tableview.delegate = self
//    //4) self.tableView.reloadData()
//
//    @IBOutlet weak var tableView: UITableView!
//
//    //wf
//    //var posts: [[String:Any]] = []
//    var posts = [[String:Any]]() // to store posts //[[]] two [] because it is array inside the dictionary, check Tumblr api
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        // Network request snippet
//        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let data = data,
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                //print(dataDictionary)
//
//                // Get the dictionary from the response key
//                let responseDictionary = dataDictionary["response"] as! [String: Any] //also need to tell what type JSON is
//                //check response in Tumblr's JSON return
//
//                // Store the returned array of dictionaries in our posts property
//                self.posts = responseDictionary["posts"] as! [[String: Any]]
//            }
//        }
//        task.resume()
//    }
//
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
