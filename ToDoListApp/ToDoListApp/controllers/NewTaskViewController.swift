//
//  NewTaskViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/18/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var currentPriority: UILabel!
    @IBOutlet weak var currentProgress: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    @IBOutlet weak var reminderMe: UILabel!
    
    @IBOutlet weak var priority: UILabel!
    
    @IBOutlet weak var cellheight: UITableViewCell!
    //    var datePicker = DatePickerController()
    
    @IBOutlet weak var textViewBottomLayoutGuideConstraint: NSLayoutConstraint!
    var needMovetextview = false
    
    var todoItem = TodoList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< 返回", style: UIBarButtonItemStyle.Plain, target: self, action:"returnTodoListVC")
        //        navigationItem.backBarButtonItem = navigationItem.leftBarButtonItem
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        let todo = todoItem
         println("NewTaskViewVC-QueryTodoListItemTable-startTime:\(todo.startTime),finishTime:\(todo.finishTime),reminderMe:\(todo.reminderTime),currentPriority:\(todo.currentPriority),currentProgress:\(todo.currentProgress),taskName:\(todo.taskName)")
        
        startTime.text = todoItem.startTime
        finishTime.text = todoItem.finishTime
        reminderMe.text = todoItem.reminderTime
        currentPriority.text =  todoItem.currentPriority
        currentProgress.text = todoItem.currentProgress
        taskName.text = todoItem.taskName
       

        if(!todo.isNewTask)
        {
            let todolist = SqliteHelper.queryDataWithField(todoItem)
            
            startTime.text = todolist.startTime
            finishTime.text = todolist.finishTime
            currentPriority.text =  todolist.currentPriority
            currentProgress.text = todolist.currentProgress
            reminderMe.text = todolist.reminderTime
            remark.text = todolist.remarks
            taskName.text = todolist.taskName
            println("NewTaskViewVC-QueryTodoListItemTable-startTime:\(todolist.startTime),finishTime:\(todolist.finishTime),reminderMe:\(todolist.reminderTime)")
        }
        
        
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: true,needMovetextview:self.needMovetextview)
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: false,needMovetextview:self.needMovetextview)
    }
    
    // MARK: Convenience
    //黑科技。
    func keyboardWillChangeFrameWithNotification(notification: NSNotification, showsKeyboard: Bool,needMovetextview:Bool) {
        println("keyboard event")
        
        if(needMovetextview == false)
        {
            return
        }
        
        if(showsKeyboard)
        {
            UIView.beginAnimations("slide", context: nil)
            UIView.setAnimationDuration(0.3)
            self.view.transform = CGAffineTransformMakeTranslation(0, -250);
            UIView.commitAnimations()
        }
        else
        {
            UIView.beginAnimations("slide", context: nil)
            UIView.setAnimationDuration(0.1)
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
            UIView.commitAnimations()
        }
        
        
        
        /*
        let userInfo = notification.userInfo!
        
        let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        // Convert the keyboard frame from screen to view coordinates.
        let keyboardScreenBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        let keyboardViewBeginFrame = view.convertRect(keyboardScreenBeginFrame, fromView: view.window)
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y
        
        // The text view should be adjusted, update the constant for this constraint.
        textViewBottomLayoutGuideConstraint.constant -= originDelta
        
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(animationDuration, delay: 0, options: .BeginFromCurrentState, animations: {
        self.view.layoutIfNeeded()
        }, completion: nil)
        
        // Scroll to the selected text once the keyboard frame changes.
        let selectedRange = remark.selectedRange
        
        remark.scrollRangeToVisible(selectedRange)
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnTodoListVC()
    {
        if(newTaskValidate())
        {
            SqliteHelper.updateData(.UpdateTodoList,model:todoItem)
            SqliteHelper.updateData(.UpdateTodoListItem,model:todoItem)
            self.navigationController?.popViewControllerAnimated(true)
          

        }
        //        todoListHelper.currentTodo = todoItem
        //        SqliteHelper.insertData(.InsertAllFromTodoListItem, model: todoItem)
        
        //        self.taskInfoList.todoItem = todoItem
        //        self.navigationController?.popToViewController(self.taskInfoList, animated: true)
        //        self.navigationController?.popToViewController(<#viewController: UIViewController#>, animated: true)
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
    
    
    
    func popupAlertView()
    {
        let alertCotroller = UIAlertController(title: "请选择一个优先级", message:nil, preferredStyle: .Alert)
        
        // Create the actions.
        let hight = UIAlertAction(title: "高", style: .Destructive) { action in
            self.currentPriority.text = "高"
            self.todoItem.currentPriority = "高"
            
        }
        
        let mid = UIAlertAction(title: "中", style: .Cancel) { action in
            self.currentPriority.text = "中"
            self.todoItem.currentPriority = "中"
            
        }
        
        let low = UIAlertAction(title: "低", style: .Default) { action in
            self.currentPriority.text = "低"
            self.todoItem.currentPriority = "低"
            
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
        let percent10 = UIAlertAction(title: "0%", style: .Default) { action in
            self.currentProgress.text = "0%"
            self.todoItem.currentProgress = "0%"
        }
        
        let percent25 = UIAlertAction(title: "25%", style: .Default) { action in
            self.currentProgress.text = "25%"
            self.todoItem.currentProgress = "25%"
            
        }
        
        let percent50 = UIAlertAction(title: "50%", style: .Default) { action in
            self.currentProgress.text = "50%"
            self.todoItem.currentProgress = "50%"
            
        }
        
        let percent75 = UIAlertAction(title: "75%", style: .Default) { action in
            self.currentProgress.text = "75%"
            self.todoItem.currentProgress = "75%"
            
        }
        
        let percent90 = UIAlertAction(title: "90%", style: .Default) { action in
            self.currentProgress.text = "90%"
            self.todoItem.currentProgress = "90%"
            
        }
        
        let percent100 = UIAlertAction(title: "100%", style: .Default) { action in
            self.currentProgress.text = "100%"
            self.todoItem.currentProgress = "100%"
            
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
        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("dataPicker") as DatePickerController
        dataPickerVC.todoItem = self.todoItem
        dataPickerVC.taskInfoList = self
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
                self.todoItem.navigationTitle = "开始时间"
                poptoDateVC()
            }
            else if(row == 2)
            {
                self.todoItem.navigationTitle = "结束时间"
                poptoDateVC()
                
            }
            else if(row == 3)
            {
                self.todoItem.navigationTitle = "提醒我"
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
            
            self.todoItem.remarks = remark.text
            
        default:
            return
        }
        
        
    }
    /*   delegate  执行顺序 bool为true的情况下。
    textFieldShouldBeginEditing
    textFieldDidBeginEditing
    textFieldShouldReturn
    textFieldShouldEndEditing
    textFieldDidEndEditing
    
    optional func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
    optional func textFieldDidBeginEditing(textField: UITextField) // became first responder
    optional func textFieldShouldEndEditing(textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    optional func textFieldDidEndEditing(textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    optional func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    
    optional func textFieldShouldClear(textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    optional func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    */
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
    {
        needMovetextview = false
        println("textFieldShouldBeginEditing")
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) // return NO to disallow editing.
    {
        println("textFieldDidBeginEditing")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        println("textFieldShouldEndEditing")
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        println("textFieldDidEndEditing")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        println("textFieldShouldReturn")
        todoItem.taskName = taskName.text
        todoItem.remarks = remark.text
        
        return taskName.resignFirstResponder()
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        println("textFieldShouldClear")
        
        return true
    }
    
    //    func textViewDidBeginEditing(textView: UITextView) {
    //        // Provide a "Done" button for the user to select to signify completion with writing text in the text view.
    //        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneBarButtonItemClicked")
    //
    //        navigationItem.setRightBarButtonItem(doneBarButtonItem, animated: true)
    //    }
    //
    //
    //    func textViewShouldEndEditing(textView: UITextView) -> Bool
    //    {
    //        return remark.resignFirstResponder()
    //
    //    }
    
    
    func showHudView (text:String)
    {
        HUDController.sharedController.contentView = HUDContentView.TextView(text: text)
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
        
    }
    func newTaskValidate() -> Bool
    {
        if(startTime.text == "")
        {
            showHudView("骚年别急,先输入开始时间先。")
            return false
        }
        
        if(taskName.text == "")
        {
            showHudView("骚年别急，先输入任务名先。")
            return false
            
        }
        
    
        
        if(finishTime.text == "")
        {
            showHudView("亲，设置完成时间很重要哦。")
            //String(format: "%@ %@ Check your rear view mirror. Then depress gas pedal.", start(), changeGears("Reverse"))
            return false
        }
        
        
   
        
        return true
        
    }
    
    func doneBarButtonItemClicked() {
        // Dismiss the keyboard by removing it as the first responder.
        
        //        todoListHelper.currentTodo = todoItem
        
        //两种方式进入newTask，第一，直接按+进入，此时isNewTask肯定为true，
        //第二，按快键方式进入，此时remark肯定为空
        
        if(newTaskValidate())
        {
            
            if(todoItem.isShortcut || !todoItem.isNewTask)
            {
                SqliteHelper.updateData(.UpdateTodoList,model:todoItem)
                SqliteHelper.updateData(.UpdateTodoListItem,model:todoItem)
            }
                
            else
            {
                
                todoItem.taskID = GenID("Task")
                todoItem.isNewTask = false
                todoItem.remarks = remark.text
                //按加号添加的方式插入到todolist 表
                SqliteHelper.insertData(.InsertAllFromTodoListItem, model: todoItem)
                SqliteHelper.insertData(.InsertAllFromTodoList, model: todoItem)
                
            }
            
            
            navigationItem.setRightBarButtonItem(nil, animated: true)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        needMovetextview = true
        return needMovetextview
    }
    
    
    
    
    /*
    
    func textViewDidBeginEditing(textView: UITextView)
    {
    
    let cellh = cellheight.frame
    let frame = self.tableView.frame
    
    //        self.tableView.scrollRectToVisible(CGRectMake(0, 520, 320, 568), animated: true)
    //                UIView.animateWithDuration(0.25, animations: {
    //                    self.tableView.frame = CGRectMake(0.0, 15, self.tableView.frame.size.width, self.tableView.frame.size.height)
    //                })
    //
    UIView.animateWithDuration(0.25, animations: {
    self.tableView.frame = CGRectMake(0.0, 535, self.tableView.frame.size.width, self.tableView.frame.size.height)
    })
    
    
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
    //        remark.frame = CGRectMake(0, 0, remark.frame.size.width,108)
    //
    //        let frame = remark.frame
    //
    //        remark.setContentOffset(CGPointMake(0, 0), animated: true)
    //        cellheight.frame = CGRectMake(0, 461, cellheight.frame.width, cellheight.frame.height)
    //        self.tableView.scrollRectToVisible(CGRectMake(0, 0, 320, 568), animated: true)
    
    UIView.animateWithDuration(0.25, animations:
    {
    self.cellheight.frame = CGRectMake(0.0, 397, self.cellheight.frame.size.width, self.cellheight.frame.size.height)
    
    }, completion: nil)
    
    }
    
    //    func textViewDidChange(textView: UITextView) {
    //        remark.frame = CGRectMake(0, 0, remark.frame.size.width, 70)
    //        let frame = remark.frame
    //
    //    }
    */
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            
            let doneBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action:"doneBarButtonItemClicked")
            navigationItem.setRightBarButtonItem(doneBarButtonItem, animated: true)
            
            
        }
        
        return true
        
        //
        //        if let resultRange = text.rangeOfCharacterFromSet(NSCharacterSet.newlineCharacterSet()) {
        //
        //            let count = countElements(text)
        //
        //            if(countElements(text)==1)
        //            {
        //                textView.resignFirstResponder()
        //                return false
        //            }
        //
        //        }
        //
        //
        //        return true
    }
    //    - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    //    if ([text length] == 1 && resultRange.location != NSNotFound) {
    //    [textView resignFirstResponder];
    //    return NO;
    //    }
    //
    //    return YES;
    //    }
    
}
