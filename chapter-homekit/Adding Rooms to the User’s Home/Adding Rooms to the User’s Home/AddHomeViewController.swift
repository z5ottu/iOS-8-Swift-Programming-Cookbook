//
//  AddHomeViewController.swift
//  Managing the User’s Home in HomeKit
//
//  Created by Vandad Nahavandipoor on 7/24/14.
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
import HomeKit

class AddHomeViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  var homeManager: HMHomeManager!

  @IBAction func addHome(){
    
    guard let text = textField.text where text.characters.count > 0 else {
      UIAlertController.showAlertControllerOnHostController(self,
        title: "Home name", message: "Please enter the home name",
        buttonTitle: "OK")
      return
    }
    
    homeManager.addHomeWithName(text,
      completionHandler: {home, error in
        
        if error != nil{
          UIAlertController.showAlertControllerOnHostController(self,
            title: "Error happened", message: "\(error)",
            buttonTitle: "OK")
        } else {
          self.navigationController!.popViewControllerAnimated(true)
        }
        
      })
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    textField.becomeFirstResponder()
    
  }
  
}
