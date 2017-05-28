//
//  Feed.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper
class Feed:NSObject, Mappable
{
    var post_id:Int = 0
    var channel:Channel?
    var title:String = ""
    var thumb_gif:String = ""
    var width_thumb_gif:Int = 0
    var height_thumb_gif:Int = 0
    var like:Int = 0
    var comment:Int = 0
    var is_like:Int = 0
    var author:Author?
    var datetime:String = ""
    var type:String = ""
}



