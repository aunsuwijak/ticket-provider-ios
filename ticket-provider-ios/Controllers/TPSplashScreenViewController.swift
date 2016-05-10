//
//  ViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/1/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class TPSplashScreenViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progressBar?.setProgress(Float(0), animated: false)
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TPSplashScreenViewController.updateProgress), userInfo: nil, repeats: true)
        
        TPHttpManager.sharedInstance.currentUser({
            responseCode, data in
            
            // TODO: Navigate to ticket list page.
        }, errorBlock: {
            responseCode in
            
            self.navigateToLogin()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func navigateToLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = storyBoard.instantiateViewControllerWithIdentifier("TPLogin") as! TPLoginViewController
        
        self.presentViewController(loginVC, animated: false, completion: nil)
    }
    
    func updateProgress() {
        self.progressBar?.setProgress((progressBar?.progress)! + 0.5, animated: true)
    }

}

