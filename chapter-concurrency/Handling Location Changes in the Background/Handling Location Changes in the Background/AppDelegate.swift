//
//  AppDelegate.swift
//  Handling Location Changes in the Background
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
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
CLLocationManagerDelegate {
                            
  var window: UIWindow?
  var locationManager: CLLocationManager! = nil
  var isExecutingInBackground = false
  
  func locationManager(manager: CLLocationManager,
    didUpdateToLocation newLocation: CLLocation,
    fromLocation oldLocation: CLLocation){
      if isExecutingInBackground{
        /* We are in the background. Do not do any heavy processing */
      } else {
        /* We are in the foreground. Do any processing that you wish */
      }
  }
  
  func application(application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [NSObject : AnyObject]?) -> Bool {
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    return true
  }

  

  func applicationDidEnterBackground(application: UIApplication) {
    isExecutingInBackground = true
    
    /* Reduce the accuracy to ease the strain on
    iOS while we are in the background */
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
  }

  func applicationWillEnterForeground(application: UIApplication) {
    isExecutingInBackground = false
    
    /* Now that our app is in the foreground again, let's increase the location
    detection accuracy */
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

}

