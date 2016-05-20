//
//  ViewController.swift
//  Storing Videos in the Photo Library
//
//  Created by Vandad Nahavandipoor on 7/10/14.
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
import AssetsLibrary

class ViewController: UIViewController {
  
  var assetsLibrary: ALAssetsLibrary?
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    assetsLibrary = ALAssetsLibrary()
    
    let videoURL = NSBundle.mainBundle().URLForResource("sample_iTunes",
      withExtension: "mov") as NSURL?
    
    if let library = assetsLibrary{
      
      if let url = videoURL{
        
        library.writeVideoAtPathToSavedPhotosAlbum(url,
          completionBlock: {(url: NSURL!, error: NSError!) in
            
            print(url)
            
            if let theError = error{
              print("Error happened while saving the video")
              print("The error is = \(theError)")
            } else {
              print("no errors happened")
            }
            
          })
      } else {
        print("Could not find the video in the app bundle")
      }
      
    }
    
  }
  
}

