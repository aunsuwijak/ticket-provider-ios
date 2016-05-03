//
//  TPHttpManager.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/2/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TPHttpManager {
    static let sharedInstance = TPHttpManager();
    
    func createAccessToken(params: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        Alamofire.request(.POST, "https://ticket-provider-staging.herokuapp.com/oauth/token", parameters: params as? [String : AnyObject])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
        
    }
    
    func createUser(user: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        Alamofire.request(.POST, "https://ticket-provider-staging.herokuapp.com/api/v1/users", parameters: user as? [String : AnyObject] )
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }
    
    func currentUser(successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey("square_app_token")
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey("square_app_type")
        
        Alamofire.request(.GET, "https://ticket-provider-staging.herokuapp.com/api/v1/me", headers: ["Authorization": "\(tokenType): \(accessToken)"])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }
    
    func updateUser(id: Int, user: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey("square_app_token")
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey("square_app_type")
        
        Alamofire.request(.PUT, "https://ticket-provider-staging.herokuapp.com/api/v1/users" + "/\(id)", headers: ["Authorization": "\(tokenType): \(accessToken)"], parameters: user as? [String : AnyObject] )
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }
    
    func retrieveTickets(successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey("square_app_token")
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey("square_app_type")
        
        Alamofire.request(.GET, "https://ticket-provider-staging.herokuapp.com/api/v1/tickets", headers: ["Authorization": "\(tokenType!): \(accessToken!)"])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }


}
