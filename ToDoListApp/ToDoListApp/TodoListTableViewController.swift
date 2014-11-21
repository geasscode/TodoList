//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    
    var myTodoList = todoListHelper.lists
    var headerVC  = HeaderVC(nibName: "HeaderVC", bundle: NSBundle.mainBundle())
//    var todo = TodoList()
    
    var actionMap: [[(selectedIndexPath: NSIndexPath) -> Void]] {
        return [
            // Alert style alerts.
            [
                self.alert
            ],
            // Action sheet style alerts.
            [
                self.actionSheet
            ]
        ]
    }
    
    
    var tabBarView = TodoListTabBar(nibName: "TodoListTabBar", bundle: NSBundle.mainBundle())
    
    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "gestureRecognizerAction:")
        recognizer.delegate = self
        self.view.addGestureRecognizer(recognizer)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem")
        
        
        
        var nib = UINib(nibName:"TodoItemCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "todoItem")
        
        //       headerVC = HeaderVC(nibName: "HeaderVC", bundle: NSBundle.mainBundle())
        //        headerVC.newTask.text = "hello,world"
        self.tableView.tableHeaderView = headerVC.view
        //        self.tableView.tableFooterView = tabBarView.view
        
        //
        //       tabBarView.view.frame.origin.y = 430
        //
        //        self.view.addSubview(tabBarView.view)
        //
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) // Called when the view is about to made visible. Default does nothing
        
    {
         let todo = todoListHelper.currentTodo
        //        let lists = todoListHelper.lists
        todoListHelper.tempTodo = todo
        let startTimeValue   = todoListHelper.currentTodo.startTime
        
        if(todoListHelper.currentTodo.startTime != "" || todoListHelper.currentTodo.finishTime != "")
        {

                    todoListHelper.addTask(todo.remarks, dateline: todo.finishTime,complete:false)

        }
        
        //        finishTime.text =  todoListHelper.currentTodo.finishTime
//        detailInfo.text = todoListHelper.currentTodo.remarks

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
    
    
    func loadTabBar() -> UIView
    {
        //        var array = NSBundle.mainBundle().loadNibNamed("TodoListTabBar", owner: self, options: nil)
        //        tabBarView = array[0] as TodoListTabBar
        tabBarView.view = UIView(frame: CGRectMake( 0, 33, self.view.bounds.width, 65))
        
        let tableFooterView = tabBarView.view
        
        //        tabBarView.view.frame = CGRect(x: 0, y: self.view.frame.size.height - 49 , width: 320, height: 49)
        
        return tableFooterView
        
    }
    
    func addItem()
    {
        //        println("hello,world")
        //
//        todoListHelper.addTask("hello", desc: "world",complete:false)
//        //        SingletonClass.sharedInstance.todoList = todoListHelper.lists
//        
//        todoTableView.reloadData()
        
        
        
        
        //如果是xib的方式就用。
        //        var headerVC  = NewTaskViewController(nibName: "newTaskVC", bundle: NSBundle.mainBundle())
        
        
        //不要用这种初始化方式，绑定不了视图的。
        //let newtask = NewTaskViewController()
        
                let newTask  =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("newTask") as UIViewController
        
                self.navigationController?.pushViewController(newTask, animated: true)
        
        //todoListHelper.addTask(toDoListTitle.text, desc: desc.text)
        // self.view.endEditing(true)
        //        toDoListTitle.text = ""
        //        desc.text = ""
        
    }
    
    
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
    
    
    func strikeThrough() -> NSAttributedString
    {
        let buttonTitle = NSLocalizedString("Button", comment: "")
        
        // Set the button's title for normal state.
        let normalTitleAttributes = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
        ]
        
        
        let normalAttributedTitle = NSAttributedString(string: "helloworld", attributes: normalTitleAttributes)
        
        return normalAttributedTitle
        // Do any additional setup after loading the view.
        
    }
    
    func alert(_: NSIndexPath)
    {
        
    }
    
    func actionSheet(_: NSIndexPath)
    {
        
    }
    
    
    func GestureRecognizerAction()
    {
        
    }
    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(self.view.superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    func finishTime() {
        
        var todoList: UIStoryboard!
        todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        
       let newTaskVC = self.storyboard?.instantiateViewControllerWithIdentifier("newTask") as UIViewController
        
        
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
        self.navigationController?.pushViewController(newTaskVC, animated: true)
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
        
        itemCell.finishTime.text =  todoListHelper.lists[indexPath.row].finishTime
        itemCell.taskName.text =  todoListHelper.lists[indexPath.row].remarks
        
       
        let todo =  todoListHelper.tempTodo
        
        if(todo.currentPriority == "高")
        {
            itemCell.priority.text = "!!!"

        }
        
        else if(todo.currentPriority == "中")
        {
            itemCell.priority.text = "!!"

        }
        
        else if(todo.currentPriority == "低")
        {
            itemCell.priority.text = "!"
            
        }
        
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
            itemCell.taskName.attributedText = strikeThrough()
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
