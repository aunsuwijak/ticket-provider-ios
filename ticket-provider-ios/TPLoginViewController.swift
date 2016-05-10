//
//  TPLoginViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/10/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit
import MBProgressHUD
import JFMinimalNotifications

class TPLoginViewController: UIViewController, UITextFieldDelegate, JFMinimalNotificationDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.loginButton.layer.shadowOffset = CGSizeMake(2, 2)
        self.loginButton.layer.shadowOpacity = 0.2
        
        self.emailTextField.returnKeyType = UIReturnKeyType.Next
        self.emailTextField.delegate = self
        
        self.passwordTextField.returnKeyType = UIReturnKeyType.Go
        self.passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType.rawValue == self.emailTextField.returnKeyType.rawValue {
            self.passwordTextField.becomeFirstResponder()
            return true
        } else if textField.returnKeyType.rawValue == self.passwordTextField.returnKeyType.rawValue {
            self.login(self)
            return true
        }
        return false;
    }
    
    @IBAction func login(sender: AnyObject) {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        TPHttpManager.sharedInstance.createAccessToken(
            [
                "client_id": TPConstants.CLIENT_ID,
                "client_secret": TPConstants.CLIENT_SECRET,
                "grant_type": TPConstants.GRANT_TYPE,
                "email": email,
                "password": password
            ],
            successBlock: {
                responseCode, data in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                if responseCode == 200 {
                    NSUserDefaults.standardUserDefaults().setObject("\(data["access_token"])", forKey: TPConstants.ACCESS_TOKEN)
                    NSUserDefaults.standardUserDefaults().setObject("\(data["token_type"])", forKey: TPConstants.TOKEN_TYPE)
                    
                    // TODO: Navigate to ticket list page.
                } else  {
                    let alert = JFMinimalNotification(style: JFMinimalNotificationStyle.Error, title: "Login failed", subTitle: "Invalid email or password", dismissalDelay: 2)
                    alert.setTitleFont(UIFont.systemFontOfSize(22.0))
                        
                    alert.edgePadding = UIEdgeInsetsMake(20, 10, 10, 10);
                    alert.presentFromTop = true
                    alert.delegate = self;
                    self.view.addSubview(alert)
                    alert.show()
                }
            }, errorBlock: {
                responseCode in
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