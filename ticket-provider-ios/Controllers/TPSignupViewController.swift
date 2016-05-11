//
//  TPSignupViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/11/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class TPSignupViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signupButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.signupButton.layer.shadowOffset = CGSizeMake(2, 2)
        self.signupButton.layer.shadowOpacity = 0.2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func navigateToLogin(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = storyBoard.instantiateViewControllerWithIdentifier("TPLogin") as! TPLoginViewController
        
        self.presentViewController(loginVC, animated: false, completion: nil)
    }
}