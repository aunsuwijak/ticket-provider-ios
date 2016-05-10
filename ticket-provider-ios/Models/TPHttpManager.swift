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
    
    func createAccessToken(params: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: () -> Void) {
        Alamofire.request(.POST, "\(TPConstants.BASE_URL)oauth/token", parameters: params as? [String : AnyObject])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock()
                }
        }
        
    }
    
    func createUser(user: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        Alamofire.request(.POST, "\(TPConstants.BASE_URL)api/v1/users", parameters: user as? [String : AnyObject] )
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }
    
    func currentUser(successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: () -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.ACCESS_TOKEN)
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.TOKEN_TYPE)
        
        Alamofire.request(.GET, "\(TPConstants.BASE_URL)api/v1/users/me", headers: ["Authorization": "\(tokenType) \(accessToken)"])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock()
                }
        }
    }
    
    func updateUser(id: Int, user: NSDictionary, successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.ACCESS_TOKEN)
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.TOKEN_TYPE)
        
        Alamofire.request(.PUT, "\(TPConstants.BASE_URL)api/v1/users" + "/\(id)", headers: ["Authorization": "\(tokenType) \(accessToken)"], parameters: user as? [String : AnyObject] )
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }
    
    func retrieveTickets(successBlock: (responseCode: Int, data: JSON) -> Void, errorBlock: (data: JSON) -> Void) {
        let accessToken = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.ACCESS_TOKEN)
        let tokenType = NSUserDefaults.standardUserDefaults().valueForKey(TPConstants.TOKEN_TYPE)
        
        Alamofire.request(.GET, "\(TPConstants.BASE_URL)api/v1/tickets", headers: ["Authorization": "\(tokenType!) \(accessToken!)"])
            .responseJSON { response in
                if response.result.isSuccess {
                    successBlock(responseCode: (response.response?.statusCode)!, data: JSON(response.result.value!))
                } else {
                    errorBlock(data: JSON(response.result.value!))
                }
        }
    }


}
