//
//  TPProfileViewController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/12/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit

class TPProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        print("profile")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.addLeftBarButtonWithImage(UIImage(named: "HamburgerIcon")!)
    }
}
