//
//  CustomerTabBarViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/20/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class CustomerTabBarViewController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override  func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!)
    {
        let  currentTag = item.tag
        
        if item.tag == 3{
            popupActionSheet()
            // we are in new view controller
            //            info.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            //            self.presentViewController(info, animated: true, completion: nil)
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    {
        let selectVC = tabBarController.viewControllers?[tabBarController.selectedIndex] as UIViewController
        if(selectVC == viewController)
        {
            return false
        }
        else
        {
            return true;
        }
        
    }
    
    func popupActionSheet()
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // Create the actions.
        let destructiveAction = UIAlertAction(title: "高", style: .Destructive) { action in
            NSLog("The \"Other\" alert action sheet's destructive action occured.")
        }
        
        let cancelAction = UIAlertAction(title: "中", style: .Cancel) { action in
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        
        let defaultAction = UIAlertAction(title: "低", style: .Default) { action in
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
