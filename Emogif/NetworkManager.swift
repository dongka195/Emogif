//
//  Networking.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MagicMapper


class EmogifServices: NSObject
{
    var code : Int = 0
    var message : String = ""
    var data : Any?
}


extension UIViewController
{
    func _requestFeedHome(completion: @escaping (_ response: FeedHome?) -> Void)
    {
        Alamofire.request(API_HOME,
                          method: .post,
                          parameters: ["token":DEFAULT_TOKEN],
                          encoding: URLEncoding.default,
                          headers: nil)
        .responseJSON { (response) in
            switch response.result
            {
            case .success:
               if let dictionary = response.result.value as? KeyValue
               {
                completion(FeedHome(dictionary))
               }
               else{
                    completion(nil)
                }
            case .failure(let error):
                log.error("Error = \(error)")
            }
        }
    }
    
    func _requestPostDetail(postID:Int,completion: @escaping (_ response: PostSearch?) -> Void)
    {
        Alamofire.request(API_DETAIL,
                          method: .post,
                          parameters: ["token":DEFAULT_TOKEN,"post_id":postID,"uuid":UUID]
                          )
            .responseJSON { (response) in
                switch response.result
                {
                case .success:
                    if let dictionary = response.result.value as? KeyValue
                    {
                        completion(PostSearch(dictionary))
                        
                    }
                    else{
                        completion(nil)
                    }
                case .failure(let error):
                    log.error("Error = \(error)")
                }
        }

    }
}
extension UITableViewCell
{
    func _requestSuggest(completion: @escaping (_ response: FeedHome?) -> Void)
    {
        Alamofire.request(API_HOME,
                          method: .post,
                          parameters: ["token":DEFAULT_TOKEN],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) in
                switch response.result
                {
                case .success:
                    if let dictionary = response.result.value as? KeyValue
                    {
                        completion(FeedHome(dictionary))
                    }
                    else{
                        completion(nil)
                    }
                case .failure(let error):
                    log.error("Error = \(error)")
                }
        }
    }

}
