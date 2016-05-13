//
//  TPSidedrawerViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/12/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class TPSidedrawerViewController: UIViewController {
    
    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var profileViewController: UIViewController!
    var ticketListViewController: UIViewController!
    var splashScreenViewController: UIViewController!
    
    override func viewDidLoad() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileVC = storyBoard.instantiateViewControllerWithIdentifier("TPProfile") as! TPProfileViewController
        let ticketListVC = storyBoard.instantiateViewControllerWithIdentifier("TPTicketList") as! TPTicketListViewController
        let splashVC = storyBoard.instantiateViewControllerWithIdentifier("TPSplash") as! TPSplashScreenViewController
        
        self.profileViewController = UINavigationController(rootViewController: profileVC)
        self.ticketListViewController = UINavigationController(rootViewController: ticketListVC)
        self.splashScreenViewController = UINavigationController(rootViewController: splashVC)
        
        TPHttpManager.sharedInstance.currentUser(
            {
                responseCode, data in
                if responseCode == 200 {
                    self.nameLabel.text = "\(data["user"]["name"])"
                    self.emailLabel.text = "\(data["user"]["email"])"
                } else {
                    // TODO: Handle this error
                }
            }, errorBlock: {
                // TODO: Handle this error
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        self.profileIcon.layer.cornerRadius = self.profileIcon.frame.size.height / 2
        self.profileIcon.layer.masksToBounds = true
        self.profileIcon.layer.borderWidth = 0
    }
    
    @IBAction func navigateToProfile(sender: AnyObject) {
        self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
    }
    
    
    @IBAction func navigateToMyTickets(sender: AnyObject) {
        self.slideMenuController()?.changeMainViewController(self.ticketListViewController, close: true)
    }
    
    @IBAction func logout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(TPConstants.ACCESS_TOKEN)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(TPConstants.TOKEN_TYPE)
        
        self.slideMenuController()?.changeMainViewController(self.splashScreenViewController, close: true)
    }
}