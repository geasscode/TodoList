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
        
        var nib = UINib(nibName:"TodoItemCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "todoItem")
        
        var headerVC:HeaderVC = HeaderVC(nibName: "HeaderVC", bundle: NSBundle.mainBundle())
//        headerVC.newTask.text = "hello,world"
        
        self.tableView.tableHeaderView = headerVC.view
    }
    
    
    
    override func viewWillAppear(animated: Bool) // Called when the view is about to made visible. Default does nothing
        
    {
        todoTableView.reloadData()
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
    
    
    func myheaderView() -> UIView
    {
        
        
        let headerView = UIView(frame: CGRectMake( 0, 0, self.view.bounds.width, 100))
        
        var label:UILabel! = UILabel(frame: CGRectMake(15, 10, 80, 80))
        label.text = "头像"
        label.textAlignment = NSTextAlignment.Left
        
        
        headerView.backgroundColor = UIColor.clearColor()
        
    
        
        var seperatorView  = UIView(frame: CGRectMake(15, headerView.frame.size.height-1, headerView.frame.width, 1))
        seperatorView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
        headerView.addSubview(label)
        headerView.addSubview(seperatorView)
        return headerView;
    }
    
    func finishTime() {
        
        var todoList: UIStoryboard!
        todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        
        
        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("todoListTime") as UIViewController
        
        //        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("dataPicker") as UIViewController
        //
        //
        //        self.navigationController?.pushViewController(dataPickerVC, animated: true)
        
        
        //返回push的上一视图：
        //返回指定视图popToViewController
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
        //'Receiver (<ToDoListApp.UserAddVC: 0x7fbdd8e257c0>) has no segue with identifier 'dataPicker''
        //只适合同一个storyboard的不同ViewController在带有箭头的成为segue那里设置identifier。
        // self.performSegueWithIdentifier("dataPicker", sender: self)
        //使用self.presentViewController意味着导航条会失效，弄了很长时间才发现。
        self.navigationController?.pushViewController(dataPickerVC, animated: true)
//        self.presentViewController(dataPickerVC, animated: true, completion: nil)
        
    }
    
    
   

    
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
        
        tableView.moveRowAtIndexPath(indexPath, toIndexPath: NSIndexPath(forRow: todoListHelper.lists.count - 1, inSection: 0))
        
        finishTime()
        
        //todoListHelper.lists = SingletonClass.sharedInstance.todoList
        //        println("diselect result is\(tappedItem.hascomplete)")
        //todoTableView.reloadData()
        
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        navigationItem.setHidesBackButton(editing, animated: animated)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let itemCell = tableView.dequeueReusableCellWithIdentifier("todoItem", forIndexPath: indexPath) as TodoItemTableViewCell
        todoListHelper.currentTodo = todoListHelper.lists[indexPath.row]

        itemCell.finishTime.text =  todoListHelper.lists[indexPath.row].name
        itemCell.taskName.text =  todoListHelper.lists[indexPath.row].desc
        itemCell.checkbox.hidden = false
        
        /*
        // Configure the cell...
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "todolist")
        
        todoListHelper.currentTodo = todoListHelper.lists[indexPath.row]
        //cell.textLabel.text = SingletonClass.sharedInstance.todoList[indexPath.row].name
        cell.textLabel.text =  todoListHelper.lists[indexPath.row].name
        
         cell.imageView.image = UIImage(named: "icon-calendar.png")
         //cell.imageView.image = UIImage(named: "uncheck.png")
        
        // cell.detailTextLabel?.text = SingletonClass.sharedInstance.todoList[indexPath.row].desc
        cell.detailTextLabel?.text = todoListHelper.lists[indexPath.row].desc
        cell.accessoryType =  .DisclosureIndicator
        */
        let taskcheck = todoListHelper.currentTodo.taskfinish
        if(taskcheck)
        {
          itemCell.checkbox.selected = taskcheck
        }
        
        if(todoListHelper.currentTodo.finishTime != "")
        {
             itemCell.finishTime.text = "预计完成时间:" + todoListHelper.currentTodo.finishTime
//            cell.detailTextLabel?.text = "预计完成时间:" + todoListHelper.currentTodo.finishTime
        }
        //        let check = SingletonClass.sharedInstance.todoList[indexPath.row] as TodoList
        let check = todoListHelper.lists[indexPath.row] as TodoList
        
        
        //        if check.hascomplete{
        //  cell.accessoryType = .Checkmark
        //
        //        }
        //        else{
        //            cell.accessoryType = .None
        //
        //        }
        //
//        return cell
        return itemCell
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
        
        
        let item = todoListHelper.lists[fromIndexPath.row]
        todoListHelper.lists.removeAtIndex(fromIndexPath.row)
        todoListHelper.lists.insert(item, atIndex: toIndexPath.row)
        
        //        let item = todoListHelper.lists[fromIndexPath.row - 1]
        
        //        let item = list[fromIndexPath.row - 1]
        //        list.moveItem(item, toIndex: toIndexPath.row - 1)
        //
        //        // Notify the document of a change.
        //        document.updateChangeCount(.Done)
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        //        if indexPath.row == 0 {
        //            return false
        //        }
        
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //
    //        var index : NSIndexPath = sender as NSIndexPath
    //
    //        var datePicker:DatePickerController=segue.destinationViewController as DatePickerController
    //        datePicker.modifyDetail = todoListHelper.lists[index.row].desc
    //        datePicker.navigationTitle = todoListHelper.lists[index.row].name
    //
    //        //        datePicker.delegate=self
    //        //        channelC.channelData=self.channelData
    //    }
    //
    
}
