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
    
    override func viewDidAppear(animated: Bool) {
        self.profileIcon.layer.cornerRadius = self.profileIcon.frame.size.height / 2
        self.profileIcon.layer.masksToBounds = true
        self.profileIcon.layer.borderWidth = 0
    }
}