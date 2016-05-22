//
//  TPSlideMenuController.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/12/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class TPSlideMenuController: SlideMenuController {
    
    override func track(trackAction: TrackAction) {
        switch trackAction {
        case .LeftTapOpen:
            (self.leftViewController as! TPSidedrawerViewController).updateProfile()
            break
        default: break
        }
    }
}
