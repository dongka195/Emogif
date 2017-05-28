//
////  AdsManager.swift
////  MusicPlayer
////
////  Created by oneweek on 4/19/17.
////  Copyright © 2017 Harry Nguyen. All rights reserved.
//
//
//import UIKit
//import GoogleMobileAds
//import PKHUD
//
//class AdsManager: NSObject,GADInterstitialDelegate {
//    
//    static let shared : AdsManager = {
//        let instance = AdsManager()
//        
//        return instance
//    }()
//    
//    var interAds : GADInterstitial?
//    typealias CompletedShowAds = (_ finish:Bool) -> Void
//    var completedShowAds: CompletedShowAds?
//    var vcPresent : UIViewController?
//    
//    //MARK: - ADS
//    func checkShowAds(percent:Int)->Bool{
//        let randomNum:UInt32 = arc4random_uniform(100) // range is 0 to 99
//        if randomNum < UInt32(percent) {
//            return true
//        }
//        return false
//    }
//    func createAndLoadInterstitial(percent:Int,vc:UIViewController,completed: @escaping CompletedShowAds) {
//        self.completedShowAds = completed
//        if self.checkShowAds(percent: percent) == true {
//            HUD.show(.labeledProgress(title: "Loading ads", subtitle: ""))
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                self.vcPresent = vc
//                self.interAds = GADInterstitial(adUnitID: AdFullId)
//                self.interAds?.delegate = self
//                self.interAds?.load(GADRequest())
//            })
//        }else{
//            self.completedShowAds?(false)
//        }
//    }
//    
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        LogD("interstitialDidReceiveAd")
//        if let vc = self.vcPresent {
//            ad.present(fromRootViewController: vc)
//        }else{
//            self.completedShowAds?(false)
//        }
//        HUD.hide()
//    }
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        LogD("interstitialDidDismissScreen")
//        self.completedShowAds?(true)
//        HUD.hide()
//        self.interAds = nil
//    }
//    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
//        LogD("interstitialDidFail")
//        self.completedShowAds?(false)
//        HUD.hide()
//        self.interAds = nil
//    }
//    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
//        LogD("didFailToReceiveAdWithError = \(error)")
//        self.completedShowAds?(false)
//        HUD.hide()
//        self.interAds = nil
//    }
//}
