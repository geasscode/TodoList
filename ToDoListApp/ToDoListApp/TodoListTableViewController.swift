//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit


class TodoListTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    
    
    var myTodoList:[TodoList] = []
    var todoItem = TodoList()
    var selectedIndex = 0;
    
    var headerVC  = HeaderVC(nibName: "HeaderVC", bundle: NSBundle.mainBundle())
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
    
    struct TabBarIndex {
        
        private static let clickedHistoryTab = 0
        private static let clickedFinishTab = 1
        private static let clickedEmergencyTab = 2
        private static let clickedSortTab = 3
    }
    
    var tabBarView = TodoListTabBar(nibName: "TodoListTabBar", bundle: NSBundle.mainBundle())
    
    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.separatorStyle = .None
        let longPressEvent = UILongPressGestureRecognizer(target: self, action: "longPressTodo:")
        //        longPressEvent.delegate = self
        longPressEvent.minimumPressDuration = 1.0;
        self.tableView.addGestureRecognizer(longPressEvent)
        loadMySqlite()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleTextFieldTextDidChangeNotification:", name: "taskName", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleCheckboxDidChangeNotification:", name: "hasFinish", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSortDidChangeNotification:", name: "sort", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSideBarDateSortDidChangeNotification:", name: "sideBarDateSort", object: nil)
        
        
        
        //        var recognizer = UIPanGestureRecognizer(target: self, action: "gestureRecognizerAction")
        //        recognizer.delegate = self
        //        self.view.addGestureRecognizer(recognizer)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        /* 自定义navigation BarButtonItem
        
        let leftbutton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftbutton.backgroundColor = UIColor.blueColor()
        leftbutton.setTitle("取消", forState: UIControlState.Normal)
        leftbutton.layer.masksToBounds = true
        leftbutton.layer.borderWidth = 1
        leftbutton.frame = CGRectMake(0, 100, 60, 30)
        leftbutton.addTarget(self, action: "cancelBarButtonItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
        let leftbarButton = UIBarButtonItem(customView: leftbutton)
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        */
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "burger.png"), style: .Plain, target: self, action: "sideBar")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem")
        // let leftBarButton:UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action:"returnTodoList")
        
        
        
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
        let selectedIndex = TodoHelper.TabBarIndex.currentIndex
        println("currentTabBar is \(selectedIndex)")
        let docsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        println("sqlite path is \(docsPath)")
        
        //        let array = SqliteHelper.queryData(.QueryAllFromTodoList)
        
        if(selectedIndex == TabBarIndex.clickedHistoryTab )
        {
            //history
            //myTodoList = SqliteHelper.queryData(.QueryAllFromTodoList)
            myTodoList = SqliteHelper.queryType(.QueryAllUndoTask)
            
        }
            
        else if (selectedIndex == TabBarIndex.clickedFinishTab)
        {
            //finish
            myTodoList = SqliteHelper.queryType(.QueryFinishedTask)
            
        }
            
        else if (selectedIndex == TabBarIndex.clickedEmergencyTab)
        {
            //emergency
            myTodoList = SqliteHelper.queryType(.QueryEmergencyTask)
            
        }
            
        else if (selectedIndex == TabBarIndex.clickedSortTab)
        {
            //sort
            myTodoList = SqliteHelper.queryData(.QueryAllFromTodoList)
            // popupActionSheet()
            
            
        }
        
        
        todoTableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){


       cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)

        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
       })
        
    }

    /*
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation != .None) {
            
//            AMWaveViewController.animationControllerForOperation(operation)
//           AMWaveViewController.
        
//            return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
        }
        return nil;
    }
    */

    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool {
        
        if (action == "cut:")
        {
            return false
        }
            
        else if(action == "copy:")
            
        {
            return true
        }
            
        else if(action == "paste:")
        {
            return false
        }
            
        else if(action == "select:")
        {
            return false
        }
            
        else if(action == "selectAll:")
        {
            return false
        }
            
        else
        {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        if (action == "copy:") {
            
            UIPasteboard.generalPasteboard().string = myTodoList[indexPath.row].startTime
            
            
        }
        
        if (action == "cut:") {
            
            UIPasteboard.generalPasteboard().string = myTodoList[indexPath.row].startTime
            
//            [arrayValue  replaceObjectAtIndex:indexPath.rowwithObject:@""];
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
            
        }
        
        if (action == "paste:") {
            
            let pasteString = UIPasteboard.generalPasteboard().string
            
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)

            
//            NSString *pasteString = [UIPasteboard  generalPasteboard].string;
//            
//            NSString *tmpString = [NSString  stringWithFormat:@"%@%@",[arrayValue  objectAtIndex:indexPath.row],pasteString];
//            
//            [arrayValue   replaceObjectAtIndex:indexPath.rowwithObject:tmpString];
//            
//            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationNone];
            
        }
    }
    
    func longPressTodo(gestureRecognizer:UIGestureRecognizer)    {
        
        if(gestureRecognizer.state == .Began)
        {
            let point = gestureRecognizer.locationInView(self.tableView)
            
            var indexPath = self.tableView.indexPathForRowAtPoint(point)
            
            
            if let index = indexPath
            {
                
                
                let focusRow = index.row
                let currentItem = myTodoList[focusRow] as TodoList
                
                myTodoList.removeAtIndex(index.row)
                
                tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
                
                SqliteHelper.deleteTodoList(currentItem.taskID)
                
                
            }
        }
    }
    
    func popupActionSheet()
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        
        let datelineSort = UIAlertAction(title: "按到期日排序", style: .Cancel) { action in
            self.myTodoList = SqliteHelper.queryType(.QueryDeadLineTask)
            self.todoTableView.reloadData()
            NSLog("The \"QueryDeadLineTask\" alert action sheet's other action occured.")
        }
        
        let createDateSort = UIAlertAction(title: "按创建日期排序", style: .Default) { action in
            self.myTodoList = SqliteHelper.queryType(.QueryCreateDateTask)
            self.todoTableView.reloadData()
            
            
            NSLog("The \"QueryCreateDateTask\" alert action sheet's other action occured.")
        }
        
        let prioritSort = UIAlertAction(title: "按优先级排序", style: .Destructive) { action in
            self.myTodoList = SqliteHelper.queryType(.QueryPriority)
            self.todoTableView.reloadData()
            
            
            NSLog("The \"QueryPriority\" alert action sheet's other action occured.")
        }
        
        alertController.addAction(datelineSort)
        alertController.addAction(createDateSort)
        alertController.addAction(prioritSort)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        //        let notificationCenter = NSNotificationCenter.defaultCenter()
        //        notificationCenter.removeObserver(self, name: "taskName", object: nil)
        //        notificationCenter.removeObserver(self, name: "hasFinish", object: nil)
        
    }
    
    deinit
    {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: "taskName", object: nil)
        notificationCenter.removeObserver(self, name: "hasFinish", object: nil)
        notificationCenter.removeObserver(self, name: "sort", object: nil)
        notificationCenter.removeObserver(self, name: "sideBarDateSort", object: nil)
        
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
    
    
    func loadMySqlite()
    {
        SqliteHelper.createTable()
    }
    
    
    
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as UITextField
        let todo = TodoList()
        //        todo.currentPriority = "!"
        todo.taskName = textField.text
        todo.taskID = GenID("Task")
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //            formatter.dateFromString("yyyy-MM-dd")
        let date = NSDate()
        todo.finishTime = formatter.stringFromDate(date)
        
        //        todo.finishTime = "明天"
        todo.isShortcut = true
        todo.isNewTask = false
        myTodoList.append(todo)
//        todo.isNewTask = false
        SqliteHelper.insertData(.InsertAllFromTodoList,model: todo)
        SqliteHelper.insertData(.InsertAllFromTodoListItem, model: todo)
        
        todoTableView.reloadData()
    }
    
    func handleSideBarDateSortDidChangeNotification(notification: NSNotification)
    {
        let currentRow = notification.object as Int
        
        switch(currentRow)
        {
            //0 is today, 1 is tomorroy, 2 is 7days.
            
        case 0:
            myTodoList = SqliteHelper.queryType(.QueryTodayTask)
            
            sideMenuController()?.sideMenu?.hideSideMenu()
            
            todoTableView.reloadData()
            
            
        case 1:
            myTodoList = SqliteHelper.queryType(.QueryTomorrow)
            sideMenuController()?.sideMenu?.hideSideMenu()
            
            todoTableView.reloadData()
            
        case 2:
            myTodoList = SqliteHelper.queryType(.QueryOneWeek)
            sideMenuController()?.sideMenu?.hideSideMenu()
            
            todoTableView.reloadData()
            
        default :
            return
        }
    }
    
    func handleCheckboxDidChangeNotification(notification: NSNotification) {
        
        //        let hasFinish = notification.object as Bool
        let btn = notification.object as UIButton
        //        let clickedCell =  btn.superview?.superview as UITableViewCell
        //        let indexPath = todoTableView.indexPathForCell(clickedCell)!
        //        let currentRow :Int = indexPath.row
        
        var clickedItem:TodoList
        
        let pointInTable: CGPoint = btn.convertPoint(btn.bounds.origin, toView: todoTableView)
        
        if let cellIndexPath = todoTableView.indexPathForRowAtPoint(pointInTable)
        {
            let currentRow = cellIndexPath.row
            let clickedItem = myTodoList[currentRow] as TodoList
            println("item taskName is \(clickedItem.taskName)")
            
            let hasFinish = btn.selected
            
            if(hasFinish)
            {
                clickedItem.hasTaskfinish = true
                SqliteHelper.updateData(.UpdateTodoList, model: clickedItem)
                
                myTodoList.removeAtIndex(currentRow)
                todoTableView.deleteRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Right)
                
            }
                
            else
            {
                clickedItem.hasTaskfinish = false
                SqliteHelper.updateData(.UpdateTodoList, model: clickedItem)
            }
            
            
        }
        
        
        
        
        
        //        todoTableView.reloadData()
        
    }
    
    func handleSortDidChangeNotification (notification: NSNotification)
    {
        let sortName = notification.object as String
        
        if(sortName == "按到期日排序")
        {
            self.myTodoList = SqliteHelper.queryType(.QueryDeadLineTask)
        }
            
        else if (sortName == "按创建日期排序")
        {
            self.myTodoList = SqliteHelper.queryType(.QueryCreateDateTask)
            
        }
            
        else
        {
            self.myTodoList = SqliteHelper.queryType(.QueryPriority)
            
        }
        
        self.todoTableView.reloadData()
        
    }
    
    
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
        
        //如果是xib的方式就用。
        //        var headerVC  = NewTaskViewController(nibName: "newTaskVC", bundle: NSBundle.mainBundle())
        
        
        //不要用这种初始化方式，绑定不了视图的。
        //let newtask = NewTaskViewController()
        
        let newTask  =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("newTask") as NewTaskViewController
        var item = TodoList()
        newTask.todoItem = item
        self.navigationController?.pushViewController(newTask, animated: true)
        
    }
    
    func sideBar ()
    {
        toggleSideMenuView()
        
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
    
    
    func strikeThrough(finishTaskName:String) -> NSAttributedString
    {
        
        //let buttonTitle = NSLocalizedString("Button", comment: "")
    
        
        // Set the button's title for normal state.
        let normalTitleAttributes = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
        ]
        
        
        let normalAttributedTitle = NSAttributedString(string: finishTaskName, attributes: normalTitleAttributes)
        
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
    
    
    //    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    //        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
    //            let translation = panGestureRecognizer.translationInView(self.view.superview!)
    //            if fabs(translation.x) > fabs(translation.y) {
    //                return true
    //            }
    //            return false
    //        }
    //        return false
    //    }
    
    func taskInfo() {
        
        var todoList: UIStoryboard!
        todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        
        let newTaskVC = self.storyboard?.instantiateViewControllerWithIdentifier("newTask") as NewTaskViewController
        
        
        
        
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
    
    func stringConvertToInt(currentProgress:String) -> Int
    {
        switch(currentProgress)
        {
            
        case "0%":
            return 0
        case "25%":
            return 25
        case "50%":
            return 50
        case "75%":
            return 75
        case "90%":
            return 90
        case "100%":
            return 100
        default :
            return 0
        }
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //        return todoListHelper.lists.count;
        println("tableView count is \(myTodoList.count)")
        
        return myTodoList.count;
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // let  selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        todoTableView.deselectRowAtIndexPath(indexPath, animated: false)
        //var tappedItem = SingletonClass.sharedInstance.todoList[indexPath.row] as TodoList
        //        var tappedItem = todoListHelper.lists[indexPath.row] as TodoList
        
        var todoItem = myTodoList[indexPath.row] as TodoList
        
        
        
        todoItem.hascomplete = !todoItem.hascomplete
        //SingletonClass.sharedInstance.todoList[indexPath.row].hascomplete = tappedItem.hascomplete
        //        todoListHelper.lists[indexPath.row].hascomplete = tappedItem.hascomplete
        myTodoList[indexPath.row].hascomplete = todoItem.hascomplete
        
        
        tableView.moveRowAtIndexPath(indexPath, toIndexPath: NSIndexPath(forRow: myTodoList.count - 1, inSection: 0))
        
        let newTaskVC = self.storyboard?.instantiateViewControllerWithIdentifier("newTask") as NewTaskViewController
        
        todoItem.currentRow = indexPath.row
        newTaskVC.todoItem = todoItem
        
        
        self.navigationController?.pushViewController(newTaskVC, animated: true)
        
        // taskInfo()
        
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
        let currentTodoItem = myTodoList[indexPath.row]
        itemCell.finishTime.text =  myTodoList[indexPath.row].finishTime
        itemCell.taskName.text =  myTodoList[indexPath.row].taskName
        itemCell.checkbox.selected = myTodoList[indexPath.row].hasTaskfinish
        println("checkbox is \(itemCell.checkbox.selected)")
        
        let increase = stringConvertToInt(myTodoList[indexPath.row].currentProgress)
        itemCell.currentProgress(increase)
        
        if(currentTodoItem.hasTaskfinish)
        {
            itemCell.checkbox.selected = true
            itemCell.taskName.attributedText = strikeThrough(itemCell.taskName.text!)
        }
        
        if(currentTodoItem.currentPriority == "高")
        {
            itemCell.priority.text = "!!!"
            
        }
            
        else if(currentTodoItem.currentPriority == "中")
        {
            itemCell.priority.text = "!!"
            
        }
            
        else if(currentTodoItem.currentPriority == "低")
        {
            itemCell.priority.text = "!"
            
        }
        
        itemCell.checkbox.hidden = false
        
        
        itemCell.finishTime.text = "预计完成时间:" + currentTodoItem.finishTime
        
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
        //        let taskcheck = todoListHelper.currentTodo.taskfinish
        //        if(taskcheck)
        //        {
        //            itemCell.checkbox.selected = taskcheck
        //            itemCell.taskName.attributedText = strikeThrough()
        //        }
        /*
        if(currentTodoItem.finishTime != "")
        {
        itemCell.finishTime.text = "预计完成时间:" + currentTodoItem.finishTime
        //            cell.detailTextLabel?.text = "预计完成时间:" + todoListHelper.currentTodo.finishTime
        }
        
        else
        {
        itemCell.finishTime.text = "预计完成时间:" + "明天"
        
        }*/
        //        let check = SingletonClass.sharedInstance.todoList[indexPath.row] as TodoList
        //        let check = todoListHelper.lists[indexPath.row] as TodoList
        
        
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
            let currentItem = myTodoList[indexPath.row] as TodoList
            
            myTodoList.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            SqliteHelper.deleteTodoList(currentItem.taskID)
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
        
        
        let item = myTodoList[fromIndexPath.row]
        myTodoList.removeAtIndex(fromIndexPath.row)
        myTodoList.insert(item, atIndex: toIndexPath.row)
        
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
