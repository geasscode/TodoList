//
//  TodoListDateTableViewController.swift
//  ToDoListApp
//
//  Created by desmond on 10/30/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit



class TodoListDateTableViewController: UITableViewController,FromViewControllerDelegate {
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var finishTime: UILabel!
    
    @IBOutlet weak var durationTime: UILabel!
    
    @IBOutlet weak var detailInfo: UITextView!
    
    var currentTodo =  TodoList()
    var datePicker = DatePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        datePicker.delegate = self
        startTime.text = "hello"
        
        let current = currentTodo
        detailInfo.text = todoListHelper.currentTodo.remarks
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
   
    
    override func viewWillAppear(animated: Bool) // Called when the view is about to made visible. Default does nothing
        
    {
        let todo = todoListHelper.currentTodo
        //        let lists = todoListHelper.lists
        let startTimeValue   = todoListHelper.currentTodo.startTime
        
        if(todoListHelper.currentTodo.startTime != "" || todoListHelper.currentTodo.finishTime != "")
        {
            startTime.text = startTimeValue
            finishTime.text = todoListHelper.currentTodo.finishTime
            
        }
        
//        finishTime.text =  todoListHelper.currentTodo.finishTime
        detailInfo.text = todoListHelper.currentTodo.remarks
        
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
    //
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete method implementation.
    //        // Return the number of rows in the section.
    //        return 0
    //    }
    
    
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //
    //        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    //
    //        let section = indexPath.section
    //        let row = indexPath.row
    //
    //        switch (section)
    //        {
    //            //Left Detail 左边是没有图片的。 Right Detail 有
    //
    //        case 0:
    //
    //            if(row == 0)
    //            {
    //                startTime.text = todoListHelper.currentTodo.startTime
    //            }
    //            else if (row == 1)
    //            {
    //                finishTime.text = todoListHelper.currentTodo.finishTime
    //            }
    //            //            cell.detailTextLabel?.text = "hello，moto"
    //            cell.imageView.image = UIImage(named: "icon-calendar.png")
    //            cell.selectionStyle = .Blue
    //
    //
    //        case 1:
    //
    //            todoListHelper.currentTodo.remarks = detailInfo.text
    //
    //        default:
    //            return cell
    //        }
    //
    //        return cell
    //
    //    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch (section)
        {
            
        case 0:
            
            if(row == 0)
            {
                todoListHelper.currentTodo.navigationTitle = "开始时间"
            }
            else if(row == 1)
            {
                todoListHelper.currentTodo.navigationTitle = "结束时间"
            }
            
            // self.navigationController?.pushViewController(datePicker, animated: true)
            //           self.presentViewController(datePicker, animated: true, completion: nil)
            
        case 1:
            
            todoListHelper.currentTodo.remarks = detailInfo.text
        default:
            return
            
        }
        
        
        
        //SingletonClass.sharedInstance.todoList[indexPath.row].hascomplete = tappedItem.hascomplete
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    func showDate(data: AnyObject)
    {
        let time = data as String
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    //        var index : NSIndexPath = sender as NSIndexPath
    //
    //        var datePicker:DatePickerController=segue.destinationViewController as DatePickerController
    //        datePicker.modifyDetail = todoListHelper.lists[index.row].desc
    //        datePicker.navigationTitle = todoListHelper.lists[index.row].name
    //
    //        //        datePicker.delegate=self
    //        //        channelC.channelData=self.channelData
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    }
    */
    
}
