//
//  Channel.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper


class ChannelSearch:NSObject,Mappable
{
    var code:Int = 0
    var message:String = ""
    var data:[Channel] = []
}


class Channel: NSObject,Mappable
{
    var channel_id:Int = 0
    var caption:String = ""
    var name:String = ""
    var avatar:String = ""
    var view:Int = 0
    var subscribe:Int = 0
    var is_sub:Int = 0
}
