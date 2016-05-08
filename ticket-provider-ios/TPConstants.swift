//
//  TPConstants.swift
//  ticket-provider-ios
//
//  Created by Suwijak Chaipipat on 5/8/2559 BE.
//  Copyright © 2559 Suwijak Chaipipat. All rights reserved.
//

import Foundation

class TPConstants {
    #if STAGING
        static let BASE_URL = "https://ticket-provider-staging.herokuapp.com/"
        static let CLIENT_ID = "57d17f38671433e48d15525125c43f8e614da1587af5f44258231eb9c74096b6"
        static let CLIENT_SECRET = "3c86c56b8a79f6192b19ccfd26fe4eaeb16431f113d25d7235c600deff72e478"
        static let GRANT_TYPE = "password"
        static let ACCESS_TOKEN = "square_app_token"
        static let TOKEN_TYPE = "square_app_type"
    #else
        static let BASE_URL = "https://www.squareapp.co/"
        static let CLIENT_ID = ""
        static let CLIENT_SECRET = ""
        static let GRANT_TYPE = "password"
        static let ACCESS_TOKEN = "square_app_token"
        static let TOKEN_TYPE = "square_app_type"
    #endif
}