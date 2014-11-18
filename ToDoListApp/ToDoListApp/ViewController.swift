//
//  ViewController.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class MyViewController:  UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var todoList: UIStoryboard!
        todoList = UIStoryboard(name: "Main", bundle: nil)
        
        
//        let todolistNav: UINavigationController  = todoList.instantiateViewControllerWithIdentifier("todoListTask") as UINavigationController
        let todolistVC = TodoListTableViewController()
        let headerVC = HeaderVC()
        let addVC = UserAddVC()
        let dateVC = DatePickerController()
        
        //        var contactsVC = OrderFood(nibName: "OrderFood", bundle:NSBundle.mainBundle())
        //        var orderVC = OrderViewController(nibName: "OrderViewController", bundle: NSBundle .mainBundle())
        //        var threeView = FinishContactsVC()
        
        let firstImage = UIImage(named: "icon-calendar.png")
        let secondImage = UIImage(named: "icon-contacts.png")
        var oneTabBarItem: UITabBarItem = UITabBarItem(title: "todo", image: firstImage, tag: 0)
        var twoTabBarItem: UITabBarItem = UITabBarItem(title: "addvc", image: secondImage, tag: 1)
        var threeTabBarItem: UITabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 2)
        var fouthTabBarItem: UITabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 3)
        
        threeTabBarItem.badgeValue = "2"
        fouthTabBarItem.badgeValue = "3"

        todolistVC.tabBarItem = oneTabBarItem
        addVC.tabBarItem = twoTabBarItem
        headerVC.tabBarItem = threeTabBarItem
        dateVC.tabBarItem = fouthTabBarItem
//        todolistNav.viewControllers = [todolistVC,addVC,headerVC,dateVC]
//        self.viewControllers = todolistNav.viewControllers
        
        //        orderVC.tabBarItem = twoTabBarItem
        //        threeView.tabBarItem = threeTabBarItem
       
        var todoListNav: UINavigationController = UINavigationController(rootViewController: todolistVC)
        var useraddVCNav: UINavigationController = UINavigationController(rootViewController: addVC)
        var headerNav: UINavigationController = UINavigationController(rootViewController: headerVC)
        var dateNav: UINavigationController = UINavigationController(rootViewController: dateVC)


     
        
        self.viewControllers = [todoListNav,useraddVCNav,headerVC,dateNav]
        //self.selectedViewController = self.viewControllers?[2] as HeaderVC
        
        self.selectedIndex = 1

//        self.navigationController?.pushViewController(self.tabBarController!, animated: true)
 
        
//        self.selectedViewController = self.viewControllers?.count
//        self.tabBarController?.selectedIndex = 2
        
    
   

        // Do any additional setup after loading the view, typically from a nib.
    }

 override func viewDidAppear(animated: Bool) {
    
//    var selectedImage0 : UIImage = UIImage(named:"selectedImage0.png").imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//    self.navigationController.tabBarItem.selectedImage = selectedImage0
//    let firstImage = UIImage(named: "icon-calendar.png")
//
//    let tabBar = self.tabBar
//    
//    // UITabBar Items are an array in order (0 is the first item)
//    let tabItems = tabBar.items as [UITabBarItem]
//    tabItems[0].title = "geass"
//    tabItems[0].selectedImage = firstImage
   
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

