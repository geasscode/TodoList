//
//  SideBarNavigation.swift
//  ToDoListApp
//
//  Created by desmond on 12/8/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class SideBarNavigation: ENSideMenuNavigationController, ENSideMenuDelegate  {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
               let sideBarList  =  self.storyboard?.instantiateViewControllerWithIdentifier("sideBarList") as SideBarTableViewController
        
        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: sideBarList, menuPosition:.Left)
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 200 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }

}
