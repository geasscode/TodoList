//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var myTodoList = todoListHelper.lists
    
    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Potentially incomplete method implementation.
    //        // Return the number of sections.
    //        return 0
    //    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return todoListHelper.lists.count;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // let  selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        todoTableView.deselectRowAtIndexPath(indexPath, animated: false)
        //var tappedItem = SingletonClass.sharedInstance.todoList[indexPath.row] as TodoList
        var tappedItem = todoListHelper.lists[indexPath.row] as TodoList
        
        
        tappedItem.hascomplete = !tappedItem.hascomplete
        //SingletonClass.sharedInstance.todoList[indexPath.row].hascomplete = tappedItem.hascomplete
        todoListHelper.lists[indexPath.row].hascomplete = tappedItem.hascomplete
        
        
        
        //todoListHelper.lists = SingletonClass.sharedInstance.todoList
        //        println("diselect result is\(tappedItem.hascomplete)")
        todoTableView.reloadData()
        
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        navigationItem.setHidesBackButton(editing, animated: animated)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Configure the cell...
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "todolist")
        
        //cell.textLabel.text = SingletonClass.sharedInstance.todoList[indexPath.row].name
        cell.textLabel.text =  todoListHelper.lists[indexPath.row].name
        
        // cell.detailTextLabel?.text = SingletonClass.sharedInstance.todoList[indexPath.row].desc
        cell.detailTextLabel?.text = todoListHelper.lists[indexPath.row].desc
        
        
        
        //        let check = SingletonClass.sharedInstance.todoList[indexPath.row] as TodoList
        let check = todoListHelper.lists[indexPath.row] as TodoList
        
        
        if check.hascomplete{
            cell.accessoryType = .Checkmark
            println("if method result is \(check.hascomplete)")
            
        }
        else{
            cell.accessoryType = .None
            println("else method result is \(check.hascomplete)")
            
        }
        
        return cell
    }
    
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
//        if indexPath.row == 0 {
//            return false
//        }
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            todoListHelper.lists.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        todoTableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!
    {
        return "确认要删除，不后悔？"
        
    }
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        //        let item = todoListHelper.lists[fromIndexPath.row - 1]
        
        //        let item = list[fromIndexPath.row - 1]
        //        list.moveItem(item, toIndex: toIndexPath.row - 1)
        //
        //        // Notify the document of a change.
        //        document.updateChangeCount(.Done)
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.row == 0 {
            return false
        }
        
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
