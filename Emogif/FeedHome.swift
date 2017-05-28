//
//  FeedHome.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper

class FeedHome:NSObject, Mappable
{
    var code:Int = 0
    var message:String = ""
    var data:[Feed] = []
}
