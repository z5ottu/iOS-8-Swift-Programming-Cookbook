//
//  AppDelegate.swift
//  Updating Existing Values in the Keychain
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
  
  func readExistingValue(){
    let keyToSearchFor = "Full Name"
    let service = NSBundle.mainBundle().bundleIdentifier!
    
    let query = [
      kSecClass as String :
      kSecClassGenericPassword as String,
      
      kSecAttrService as String : service,
      kSecAttrAccount as String : keyToSearchFor,
      kSecReturnAttributes as String : kCFBooleanTrue,
      
      ]
    
    var returnedAttributes: Unmanaged<AnyObject>? = nil
    let results = Int(SecItemCopyMatching(query, &returnedAttributes))
    
    if results == Int(errSecSuccess){
      
      let attributes = returnedAttributes!.takeRetainedValue() as! NSDictionary
      
      let comments = attributes[kSecAttrComment as String] as! String
      
      print("Comments = \(comments)")
      
    } else {
      print("Error happened with code: \(results)")
    }
  }

  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
      let keyToSearchFor = "Full Name"
      let service = NSBundle.mainBundle().bundleIdentifier!
      
      let query = [
        kSecClass as String :
      kSecClassGenericPassword as String,
        
        kSecAttrService as String : service,
        kSecAttrAccount as String : keyToSearchFor,
      ]
      
      var result: Unmanaged<AnyObject>? = nil
      let found = Int(SecItemCopyMatching(query, &result))
      
      if found == Int(errSecSuccess){
        
        let newData = "Mark Tremonti".dataUsingEncoding(NSUTF8StringEncoding,
          allowLossyConversion: false)
        
        let update = [
          kSecValueData as String : newData!,
          kSecAttrComment as String : "My comments"
        ]
        
        let updated = Int(SecItemUpdate(query, update))
        
        if updated == Int(errSecSuccess){
          print("Successfully updated the existing value")
          readExistingValue()
        } else {
          print("Failed to update the value. Error = \(updated)")
        }
        
      } else {
        print("Error happened. Code = \(found)")
      }
    
    
    return true
  }

}

