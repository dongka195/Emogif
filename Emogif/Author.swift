//
//  Author.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper


class Author: NSObject, Mappable
{
    var id:Int = 0
    var name:String = ""
    var avatar:String = ""
    var is_follow:Int = 0
}
