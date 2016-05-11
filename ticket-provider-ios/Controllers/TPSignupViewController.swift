//
//  TPSignupViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/11/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit
import MBProgressHUD
import JFMinimalNotifications

class TPSignupViewController: UIViewController, JFMinimalNotificationDelegate {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
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
    
    @IBAction func signup(sender: AnyObject) {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        
        let email = self.emailTextField.text!
        let name = self.nameTextField.text!
        let password = self.passwordTextField.text!
        let confirmPassword = self.confirmPasswordTextField.text!
        
        TPHttpManager.sharedInstance.createUser(
            [
                "user": [
                    "email": email,
                    "password": password,
                    "password_confirmation": confirmPassword,
                    "name": name
                ]
            ], successBlock: { (responseCode, data) in
                if responseCode == 201 {
                    TPHttpManager.sharedInstance.createAccessToken(
                        [
                        "client_id": TPConstants.CLIENT_ID,
                        "client_secret": TPConstants.CLIENT_SECRET,
                        "grant_type": TPConstants.GRANT_TYPE,
                        "email": email,
                        "password": password
                        ], successBlock: { (responseCode, data) in
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                            if responseCode == 200 {
                                NSUserDefaults.standardUserDefaults().setObject("\(data["access_token"])", forKey: TPConstants.ACCESS_TOKEN)
                                NSUserDefaults.standardUserDefaults().setObject("\(data["token_type"])", forKey: TPConstants.TOKEN_TYPE)
                                
                                // TODO: Navigate to ticket list page.
                            } else {
                                
                            }
                        }, errorBlock: {
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                            
                            // TODO: Handle this error.
                            
                    })
                } else {
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    
                    let alert = JFMinimalNotification(style: JFMinimalNotificationStyle.Error, title: "Registration failed", subTitle: "\(data["errors"][0])", dismissalDelay: 2)
                    alert.setTitleFont(UIFont.systemFontOfSize(22.0))
                    
                    alert.edgePadding = UIEdgeInsetsMake(20, 10, 10, 10);
                    alert.presentFromTop = true
                    alert.delegate = self;
                    self.view.addSubview(alert)
                    alert.show()
                }
            }, errorBlock: {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                let alert = JFMinimalNotification(style: JFMinimalNotificationStyle.Error, title: "Network error", subTitle: "Please check your internet connection", dismissalDelay: 2)
                alert.setTitleFont(UIFont.systemFontOfSize(22.0))
                
                alert.edgePadding = UIEdgeInsetsMake(20, 10, 10, 10);
                alert.presentFromTop = true
                alert.delegate = self;
                self.view.addSubview(alert)
                alert.show()
        })
        
    }
}