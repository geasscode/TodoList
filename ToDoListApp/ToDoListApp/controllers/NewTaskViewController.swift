//
//  NewTaskViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/18/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController {
    
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var currentPriority: UILabel!
    @IBOutlet weak var currentProgress: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    @IBOutlet weak var reminderMe: UILabel!
    
    @IBOutlet weak var priority: UILabel!
    
    var datePicker = DatePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let todo = todoListHelper.currentTodo
        //        let lists = todoListHelper.lists
        let startTimeValue   = todoListHelper.currentTodo.startTime
        
        if(todoListHelper.currentTodo.startTime != "" || todoListHelper.currentTodo.finishTime != "")
        {
            startTime.text = startTimeValue
            finishTime.text = todo.finishTime
            currentPriority.text =  todo.currentPriority
            currentProgress.text = todo.currentProgress
            remark.text = todo.remarks
        }
        
        //        finishTime.text =  todoListHelper.currentTodo.finishTime
        taskName.text = todoListHelper.currentTodo.remarks
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //alert 需要重构，失忆想不起代码来了。
    
    
    func popupAlertView()
    {
        let alertCotroller = UIAlertController(title: "请选择一个优先级", message:nil, preferredStyle: .Alert)
        
        // Create the actions.
        let hight = UIAlertAction(title: "高", style: .Destructive) { action in
            self.currentPriority.text = "高"
            todoListHelper.currentTodo.currentPriority = "高"

        }
        
        let mid = UIAlertAction(title: "中", style: .Cancel) { action in
            self.currentPriority.text = "中"
            todoListHelper.currentTodo.currentPriority = "中"

        }
        
        let low = UIAlertAction(title: "低", style: .Default) { action in
            self.currentPriority.text = "低"
            todoListHelper.currentTodo.currentPriority = "低"

        }
        
        //        alertCotroller.addTextFieldWithConfigurationHandler { textField in
        //           //            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleTextFieldTextDidChangeNotification:", name: UITextFieldTextDidChangeNotification, object: textField)
        //
        //            textField.secureTextEntry = true
        //        }
        // Add the actions.
        alertCotroller.addAction(hight)
        alertCotroller.addAction(mid)
        alertCotroller.addAction(low)
        
        presentViewController(alertCotroller, animated: true, completion: nil)
        
    }
    
    
    func popupProgressAlert()
    {
        let alertCotroller = UIAlertController(title: "当前进度为", message: nil, preferredStyle: .Alert)
        
        // Create the actions.
        let percent10 = UIAlertAction(title: "10%", style: .Default) { action in
            self.currentProgress.text = "10%"
            todoListHelper.currentTodo.currentProgress = "10%"
        }
        
        let percent25 = UIAlertAction(title: "25%", style: .Default) { action in
            self.currentProgress.text = "25%"
            todoListHelper.currentTodo.currentProgress = "25%"

        }
        
        let percent50 = UIAlertAction(title: "50%", style: .Default) { action in
            self.currentProgress.text = "50%"
            todoListHelper.currentTodo.currentProgress = "50%"

        }
        
        let percent75 = UIAlertAction(title: "75%", style: .Default) { action in
            self.currentProgress.text = "75%"
            todoListHelper.currentTodo.currentProgress = "75%"

        }
        
        let percent90 = UIAlertAction(title: "90%", style: .Default) { action in
            self.currentProgress.text = "90%"
            todoListHelper.currentTodo.currentProgress = "90%"

        }
        
        let percent100 = UIAlertAction(title: "100%", style: .Default) { action in
            self.currentProgress.text = "100%"
            todoListHelper.currentTodo.currentProgress = "100%"

        }
        
        //        alertCotroller.addTextFieldWithConfigurationHandler { textField in
        //           //            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleTextFieldTextDidChangeNotification:", name: UITextFieldTextDidChangeNotification, object: textField)
        //
        //            textField.secureTextEntry = true
        //        }
        // Add the actions.
        alertCotroller.addAction(percent10)
        alertCotroller.addAction(percent25)
        alertCotroller.addAction(percent50)
        alertCotroller.addAction(percent75)
        alertCotroller.addAction(percent90)
        alertCotroller.addAction(percent100)
        
        presentViewController(alertCotroller, animated: true, completion: nil)
        
    }
    //    func colorForIndex(index: Int) -> UIColor {
    //        let itemCount = toDoItems.count - 1
    //        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
    //        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    //    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func doneTask(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    func poptoDateVC()
    {
        let todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("dataPicker") as UIViewController
        self.navigationController?.pushViewController(dataPickerVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let section = indexPath.section
        let row = indexPath.row
        
        
        
        
        switch (section)
        {
            
        case 0:
            
            if(row == 1)
            {
                todoListHelper.currentTodo.navigationTitle = "开始时间"
                poptoDateVC()
            }
            else if(row == 2)
            {
                todoListHelper.currentTodo.navigationTitle = "结束时间"
                poptoDateVC()

            }
            else if(row == 3)
            {
                todoListHelper.currentTodo.navigationTitle = "提醒我"
                poptoDateVC()

            }
            
            if(row == 4)
            {
                popupAlertView()
                
            }
            
            
            //错误示范：都不同stroyboard 骚年你要星际穿越吗？
            //  self.navigationController?.pushViewController(datePicker, animated: true)
            
            
            
        case 1:
            
            if(row == 0)
            {
                popupProgressAlert()
            }
            
            
        case 2:
            
            todoListHelper.currentTodo.remarks = remark.text
            
        default:
            return
        }
        
        
    }
    
    
    
}
