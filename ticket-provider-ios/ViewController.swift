//
//  ViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/1/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TPHttpManager.sharedInstance.createAccessToken(["client_id": "57d17f38671433e48d15525125c43f8e614da1587af5f44258231eb9c74096b6", "client_secret": "3c86c56b8a79f6192b19ccfd26fe4eaeb16431f113d25d7235c600deff72e478", "grant_type": "password", "email": "ppnk_2537@hotmail.com", "password": "12345678"],
        
        successBlock: { responseCode, data in
            print(responseCode)
            NSUserDefaults.standardUserDefaults().setObject("\(data["access_token"])", forKey: "square_app_token")
            NSUserDefaults.standardUserDefaults().setObject("\(data["token_type"])", forKey: "square_app_type")
            
            TPHttpManager.sharedInstance.retrieveTickets(
                { responseCode, data in
                    print(responseCode)
                    print(data)
                }, errorBlock: { data in
                    print(data)
            })
        }, errorBlock: { data in
            print(data)
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

