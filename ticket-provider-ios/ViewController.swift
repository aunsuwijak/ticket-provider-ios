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
        
        
        TPHttpManager.sharedInstance.createAccessToken(["client_id": TPConstants.CLIENT_ID, "client_secret": TPConstants.CLIENT_SECRET, "grant_type": TPConstants.GRANT_TYPE, "email": "ppnk_2537@hotmail.com", "password": "12345678"],
        
        successBlock: { responseCode, data in
            print(responseCode)
            NSUserDefaults.standardUserDefaults().setObject("\(data["access_token"])", forKey: TPConstants.ACCESS_TOKEN)
            NSUserDefaults.standardUserDefaults().setObject("\(data["token_type"])", forKey: TPConstants.TOKEN_TYPE)
            
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

