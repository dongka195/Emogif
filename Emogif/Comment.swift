//
//  Comment.swift
//  Emogif
//
//  Created by hintoro on 5/26/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper

class CommentSearch: NSObject, Mappable
{
    var code:Int = 0
    var message:String = ""
    var data:[Comment] = []
}


class Comment: NSObject, Mappable
{
    var post_id:String = ""
    var comment_id:Int = 0
    var author:Author?
    var content:String = ""
    var datetime:String = ""
    var can_edit:Int = 0
    
    var mapFromDictionaryTypes: [String : Mappable.Type] {
        return [
            "author" : Author.self
        ]
    }
}
