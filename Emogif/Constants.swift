//
//  Constants.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import XCGLogger

let UUID = UIDevice.current.identifierForVendor!.uuidString




/*
- EndPoint: http://dev-sm.cloudapp.net/webdev/Gif_Community
- Token Default: 37ySKks6xEDy1
- Method: HTTP/POST
*/
let DEFAULT_TOKEN:String = "37ySKks6xEDy1"

//API
let BASE_URL:String = "http://dev-sm.cloudapp.net/webdev/Gif_Community"
/*  Home  */
let API_HOME:String = BASE_URL + "/feed/home"
let API_DETAIL:String = BASE_URL + "/post/detail"
let API_GETPOSTCOMMENT:String = BASE_URL + "/post/get_comment"
let API_GETALLCHANNEL = BASE_URL + "/channel/get_all_channel"
let API_SEARCH = BASE_URL + "/post/search"

/*  Logger */
let log = XCGLogger.default




/* FRAME */

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
