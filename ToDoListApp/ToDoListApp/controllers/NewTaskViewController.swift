//
//  NewTaskViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/18/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController {

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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
      let todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        
        
        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("todoListTime") as UIViewController

        
        self.navigationController?.pushViewController(dataPickerVC, animated: true)
    }

    
   
}
