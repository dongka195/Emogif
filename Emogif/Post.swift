//
//  Post.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import MagicMapper

class PostSearch:NSObject, Mappable
{
    var code:Int = 0
    var message:String = ""
    var data:Post?
    
    var mapFromDictionaryTypes: [String : Mappable.Type] {
        return [
            "data" : Post.self
        ]
    }

}
class Post : NSObject,Mappable
{
    var postId:Int = 0
    var channel:Channel?
    var title:String = ""
    var image:String = ""
    var width:Int = 0
    var height:Int = 0
    var datetime:String  = ""
    var like:Int = 0
    var comment:Int = 0
    var isLike:Int = 0
    var isBookmark:Int = 0
    var author:Author?
    
    var mapFromDictionaryTypes: [String : Mappable.Type] {
        return [
            "channel" : Channel.self,
            "author" : Author.self
        ]
    }

    
    
}
