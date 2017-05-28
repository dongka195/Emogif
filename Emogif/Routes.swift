//
//  Routes.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit

class Routes:NSObject
{
    static let shared : Routes = {
        let instance = Routes()
        return instance
    }()
    
    
    
}
extension UIViewController
{
    func _redirect(stName:String,vcName:String) ->UIViewController
    {
        let storyboard:UIStoryboard = UIStoryboard(name: stName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcName)
        return vc
    }
}
extension UITableViewCell{
    func _redirect(stName:String,vcName:String) ->UIViewController
    {
        let storyboard:UIStoryboard = UIStoryboard(name: stName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcName)
        return vc
    }

}
