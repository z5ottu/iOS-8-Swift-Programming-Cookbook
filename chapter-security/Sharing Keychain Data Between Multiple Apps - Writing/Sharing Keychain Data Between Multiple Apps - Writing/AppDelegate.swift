//
//  AppDelegate.swift
//  Sharing Keychain Data Between Multiple Apps - Writing
//
//  Created by Vandad Nahavandipoor on 7/7/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.
//  
//  You can purchase "iOS 8 Swift Programming Cookbook" from
//  the following URL:
//  http://shop.oreilly.com/product/0636920034254.do
//
//  If you have any questions, you can contact me directly
//  at vandad.np@gmail.com
//  Similarly, if you find an error in these sample codes, simply
//  report them to O'Reilly at the following URL:
//  http://www.oreilly.com/catalog/errata.csp?isbn=0636920034254

import UIKit
import Security

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?
  
  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    let key = "Full Name";
    let service = NSBundle.mainBundle().bundleIdentifier!
    /* TODO: Place your own team ID here */
    let accessGroup = "F3FU372W5M.*"
    
    /* First delete the existing one if one exists. We don't have to do this
    but SecItemAdd will fail if an existing value is in the keychain. */
    let query = [
      kSecClass as String :
      kSecClassGenericPassword as String,
      
      kSecAttrService as String : service,
      kSecAttrAccessGroup as String : accessGroup,
      kSecAttrAccount as String : key
      ]
    
    
    SecItemDelete(query)
    
    /* Then write the new value in the keychain */
    let value = "Steve Jobs"
    let valueData = value.dataUsingEncoding(NSUTF8StringEncoding,
      allowLossyConversion: false)
    
    let secItem = [
      kSecClass as String :
      kSecClassGenericPassword as String,
      
      kSecAttrService as String : service,
      kSecAttrAccount as String : key,
      kSecAttrAccessGroup as String : accessGroup,
      kSecValueData as String : valueData!,
      ]
    
    var result: Unmanaged<AnyObject>? = nil
    let status = Int(SecItemAdd(secItem, &result))
    
    switch status{
    case Int(errSecSuccess):
      print("Successfully stored the value")
    case Int(errSecDuplicateItem):
      print("This item is already saved. Cannot duplicate it")
    default:
      print("An error occurred with code \(status)")
    }
    
    return true
  }

}

