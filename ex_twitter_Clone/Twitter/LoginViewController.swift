//
//  LoginViewController.swift
//  Twitter
//
//  Created by Fung on 3/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 15
        //loginBtn.layout
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        let urlString = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: urlString, success: {
            //on login sucess, present homeTableVC
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Error. Could not login.")
            let title = "Error"
            let message = "An error has"
            //let alert = UIAlertController
        })
        
    }
    
}
