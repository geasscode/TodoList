//
//  CustomerTabBarViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/20/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class CustomerTabBarViewController: UITabBarController {
    
      var  currentTabBar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.selectedIndex = 3
        
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
        //self.selectedIndex = 3
        currentTabBar = item.tag
        TodoHelper.TabBarIndex.currentIndex = item.tag
//        let todoList  =  self.storyboard?.instantiateViewControllerWithIdentifier("TodoList") as TodoListTableViewController
//         self.navigationController?.pushViewController(todoList, animated: true)

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
        
        
        let datelineSort = UIAlertAction(title: "按到期日排序", style: .Cancel) { action in
            
            NSNotificationCenter.defaultCenter().postNotificationName("sort", object: "按到期日排序")

        }
        
        let createDateSort = UIAlertAction(title: "按创建日期排序", style: .Default) { action in
            NSNotificationCenter.defaultCenter().postNotificationName("sort", object: "按创建日期排序")
        }
        
        let prioritSort = UIAlertAction(title: "按优先级排序", style: .Destructive) { action in
            NSNotificationCenter.defaultCenter().postNotificationName("sort", object: "按优先级排序")

            NSLog("The \"Other\" alert action sheet's other action occured.")
        }
        
        alertController.addAction(datelineSort)
        alertController.addAction(createDateSort)
        alertController.addAction(prioritSort)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
