//
//  BaseTabBarViewController.swift
//  POK
//
//  Created by DONGKA on 4/26/17.
//  Copyright © 2017 DONGKA. All rights reserved.
//

import Foundation
import MMTabBarAnimation
class BaseTabBarViewController: MMTabBarAnimateController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // .iconExpand  type dont set select Image or you will not animation
        super.setAnimate(index: 0, animate: .icon(type: .scale(rate: 1.2)))
        
        super.setAnimate(index: 1, animate: .icon(type: .scale(rate: 1.2)))
        super.setAnimate(index: 2, animate: .icon(type: .scale(rate: 1.2)))
        super.setAnimate(index: 3, animate: .icon(type: .scale(rate: 1.2)))
        //        super.setAnimate(index: 4, animate: .label(type: .shake))
        
        super.setBadgeAnimate(index: 0, animate: .scale(rate: 1.2))
        super.setBadgeAnimate(index: 1, animate: .scale(rate: 1.2))
        super.setBadgeAnimate(index: 2, animate: .scale(rate: 1.2))
        super.setBadgeAnimate(index: 3, animate: .scale(rate: 1.2))
        
    }
   
    

}
