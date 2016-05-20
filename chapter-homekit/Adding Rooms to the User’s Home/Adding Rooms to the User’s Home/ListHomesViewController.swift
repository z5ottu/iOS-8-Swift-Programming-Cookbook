//
//  ViewController.swift
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

extension UIAlertController{
  class func showAlertControllerOnHostController(
    hostViewController: UIViewController,
    title: String,
    message: String,
    buttonTitle: String){
      
      let controller = UIAlertController(title: title,
        message: message,
        preferredStyle: .Alert)
      
      controller.addAction(UIAlertAction(title: buttonTitle,
        style: .Default,
        handler: nil))
      
      hostViewController.presentViewController(controller,
        animated: true,
        completion: nil)
      
  }
}

class ListHomesViewController: UITableViewController, HMHomeManagerDelegate{
  
  let addHomeSegueIdentifier = "addHome"
  let showRoomsSegueIdentifier = "showRooms"
  
  struct TableViewValues{
    static let identifier = "Cell"
  }
  
  lazy var homeManager: HMHomeManager = {
    let manager = HMHomeManager()
    manager.delegate = self
    return manager
    }()
  
  override func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      let numberOfRows = homeManager.homes.count
      
      if numberOfRows == 0 && editing{
        setEditing(!editing, animated: true)
      }
      
      editButtonItem().enabled = (numberOfRows > 0)
      
      return numberOfRows
  }
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCellWithIdentifier(
        TableViewValues.identifier, forIndexPath: indexPath)
        as UITableViewCell
      
      let home = homeManager.homes[indexPath.row] as HMHome
      
      cell.textLabel!.text = home.name
      cell.accessoryType = .DisclosureIndicator
      
      return cell
      
  }
  
  func homeManager(manager: HMHomeManager, didRemoveHome home: HMHome) {
    print("A home has been deleted")
  }
  
  func homeManagerDidUpdateHomes(manager: HMHomeManager) {
    tableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue,
    sender: AnyObject!) {
      
      if segue.identifier == addHomeSegueIdentifier{
        
        let controller = segue.destinationViewController
          as! AddHomeViewController
        controller.homeManager = homeManager
        
      }
      
      else if segue.identifier == showRoomsSegueIdentifier{
        let controller = segue.destinationViewController
          as! ListRoomsTableViewController
        controller.homeManager = homeManager
        
        let home = homeManager.homes[tableView.indexPathForSelectedRow!.row]
          as HMHome
        
        controller.home = home
      }
      
      super.prepareForSegue(segue, sender: sender)
      
  }
  
  override func tableView(tableView: UITableView,
    commitEditingStyle editingStyle: UITableViewCellEditingStyle,
    forRowAtIndexPath indexPath: NSIndexPath) {
      
      if editingStyle == .Delete{
        
        let home = homeManager.homes[indexPath.row] as HMHome
        homeManager.removeHome(home, completionHandler: {error in
          
          if error != nil{
            UIAlertController.showAlertControllerOnHostController(self,
              title: "Error",
              message: "An error occurred = \(error)",
              buttonTitle: "OK")
          } else {
            
            tableView.deleteRowsAtIndexPaths([indexPath],
              withRowAnimation: .Automatic)
            
          }
          
          })
        
      }
      
  }
  
  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    /* Don't let the user add another home while they are editing
    the list of homes. This makes sure the user focuses on the task
    at hand */
    self.navigationItem.rightBarButtonItem!.enabled = !editing
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.leftBarButtonItem = editButtonItem()
    
  }
  
}