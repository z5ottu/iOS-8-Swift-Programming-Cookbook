//
//  ViewController.swift
//  Detecting Tap Gestures
//
//  Created by Vandad Nahavandipoor on 7/8/14.
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

class ViewController: UIViewController {
  
  var tapGestureRecognizer: UITapGestureRecognizer!
  
  func handleTaps(sender: UITapGestureRecognizer){
    
    for touchCounter in 0..<sender.numberOfTouchesRequired{
      
      let touchPoint = sender.locationOfTouch(touchCounter,
        inView: sender.view)
      
      print("Touch \(touchCounter + 1): \(touchPoint)")
      
    }
    
  }
  
  required init(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)
    
    /* Create the Tap Gesture Recognizer */
    tapGestureRecognizer = UITapGestureRecognizer(target: self,
      action: "handleTaps:")
    
    /* The number of fingers that must be on the screen */
    tapGestureRecognizer.numberOfTouchesRequired = 2
    
    /* The total number of taps to be performed before the
    gesture is recognized */
    tapGestureRecognizer.numberOfTapsRequired = 3
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /* Add this gesture recognizer to our view */
    view.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
  
}

