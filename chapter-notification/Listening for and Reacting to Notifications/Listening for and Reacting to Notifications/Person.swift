//
//  Person.swift
//  Listening for and Reacting to Notifications
//
//  Created by Vandad Nahavandipoor on 7/11/14.
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

class Person: NSObject{
  var firstName: String?
  var lastName: String?
  
  func handleSetPersonInfoNotification(notification: NSNotification){
    
    firstName = (notification.userInfo![AppDelegate.personInfoKeyFirstName()]
      as? NSString)! as String
    
    lastName = (notification.userInfo![AppDelegate.personInfoKeyLastName()]
    as? NSString)! as String
    
  }
  
  override init(){
    super.init()
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "handleSetPersonInfoNotification:",
      name: AppDelegate.notificationName(),
      object: UIApplication.sharedApplication().delegate)
  }
  
  deinit{
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
}