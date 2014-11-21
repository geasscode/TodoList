//
//  CustomerTabBarViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/20/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class CustomerTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1

        
        
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
            
        }
    }
    
    /*
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
    */
    
    func popupActionSheet()
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // Create the actions.
        let letterSort = UIAlertAction(title: "按字母排序排序", style: .Destructive) { action in
            NSLog("The \"Other\" alert action sheet's destructive action occured.")
        }
        
        let datelineSort = UIAlertAction(title: "按到期日排序", style: .Cancel) { action in
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        
        let createDateSort = UIAlertAction(title: "按创建日期排序", style: .Default) { action in
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        
        let prioritSort = UIAlertAction(title: "按优先级排序", style: .Default) { action in
            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        // Add the actions.
        alertController.addAction(letterSort)
        alertController.addAction(datelineSort)
        alertController.addAction(createDateSort)
        alertController.addAction(prioritSort)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
