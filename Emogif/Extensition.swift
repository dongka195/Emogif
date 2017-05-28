//
//  Extensition.swift
//  Emogif
//
//  Created by hintoro on 5/23/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import Foundation
import UIKit
import Gifu
import Alamofire
import SwiftyGif
import SDWebImage
public var APP_VERSION : String{
    get{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
}

public var APP_BUILD : String{
    get{
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
}

public var APP_ID : String{
    get{
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    }
}
func hideKeyboard() -> Void {
    UIApplication.shared.keyWindow?.endEditing(true)
}
extension UITableView
{
    func _registerNibs(nibName:String,identifier:String){
        let viewNib = UINib(nibName: nibName, bundle: nil)
        self.register(viewNib, forCellReuseIdentifier: identifier)
    }
    func _sd_clear()
    {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
}
extension UITableViewCell
{
    func _sd_clear()
    {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }

}
extension UIImageView
{
    func _setGifImage(url:String)
    {
        let gifManager = SwiftyGifManager(memoryLimit: 20)
        Alamofire.request(url).responseData { (response) in
            if let data = response.data
            {
                print(data)
                let image = UIImage(gifData: data)
                self.setGifImage(image, manager: gifManager)
                self.startAnimatingGif()
            }
        }
    }
}
extension UICollectionView
{
    func _registerNibs(nibName:String, identifier:String){
        let viewNib = UINib(nibName: nibName, bundle: nil)
        self.register(viewNib, forCellWithReuseIdentifier: identifier)
    }
    func _sd_clear()
    {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
}
extension UIViewController
{
    func _sd_clear()
    {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
}
extension GIFImageView
{
    func getImageFromUrl(_ url:String)
    {
        Alamofire.request(url).responseData { (response) in
            if let data = response.data
            {
                self.animate(withGIFData: data)
            }
        }
    }
    func prepareForGifFromUrl(_ url:String)
    {
        
        Alamofire.request(url).responseData { (response) in
            if let data = response.data
            {
                self.prepareForAnimation(withGIFData: data)
            }
        }
    }
}
extension NSString {
    public func localized() -> String {
        return NSLocalizedString(self as String, comment: "")
    }
}
extension String {
    
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func localizedFormat( _ args: CVarArg...) -> String {
        
        return String(format: self.localized(), arguments: args)
    }
    public func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
extension UIColor {
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
