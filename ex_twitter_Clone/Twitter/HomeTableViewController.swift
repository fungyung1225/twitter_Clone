//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Fung on 3/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()//call function
    }
    
    //create function for retrevie tweets
    func loadTweet(){
       let urlString = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        let myParams = ["count": 10] //for mutilple ["count": 10,"count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: urlString, parameters: myParams, success: { (tweets:[NSDictionary]) in
            //tweets is the return from api
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)//add tweet to dic
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Count not retreive tweets!")
        })
    }

    @IBAction func onTapLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)//dismiss the screnn, back to login screen
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary //extract key from parent dic
        
        cell.userNameLbl.text = user["name"] as? String
        cell.tweetContentLbl.text = tweetArray[indexPath.row]["text"] as? String
        
        //convert url to image
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data{
            cell.profileImg.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
}
