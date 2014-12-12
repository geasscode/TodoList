//
//  DatePickerController.swift
//  ToDoListApp
//
//  Created by desmond on 10/29/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

@objc protocol FromViewControllerDelegate {
    func showDate(data: AnyObject)
}
class DatePickerController: UIViewController,UIAlertViewDelegate {
    
    var todoItem = TodoList()
    var taskInfoList = NewTaskViewController()
    
    var modifyDetail = ""
    var time = ""
    weak var delegate: FromViewControllerDelegate?
    
    
    @IBOutlet weak var datePickers: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        /*
        
        case NoStyle
        case ShortStyle
        case MediumStyle
        case LongStyle
        case FullStyle*/
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        //dateFormatter.dateFromString("yyyy-MM-dd HH:mm")
        
        return dateFormatter
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = todoItem.navigationTitle
        configureDatePicker()
    }
    
    // MARK: Configuration
    
    func configureDatePicker() {
        /*
        case Time // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
        case Date // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
        case DateAndTime // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
        case CountDownTimer
        */
        
        datePickers.datePickerMode = .DateAndTime
        
        // Set min/max date for the date picker.
        // As an example we will limit the date between now and 7 days from now.
        
        
        let now = NSDate()
        datePickers.minimumDate = now
        
        let currentCalendar = NSCalendar.currentCalendar()
        
        let dateComponents = NSDateComponents()
        dateComponents.day = 7
        //设置从今天开始之后的7天。
        let sevenDaysFromNow = currentCalendar.dateByAddingComponents(dateComponents, toDate: now, options: nil)
        datePickers.maximumDate = sevenDaysFromNow
        //设置分钟数的间隔。
        datePickers.minuteInterval = 2
        
        datePickers.addTarget(self, action: "updateDatePickerLabel", forControlEvents: .ValueChanged)
        
        updateDatePickerLabel()
    }
    
    // MARK: Actions
    
    func updateDatePickerLabel() {
        
        //如果属性定制不多的话可以用
        //dateLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        datePickers.datePickerMode = .Date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        time = dateFormatter.stringFromDate(datePickers.date)
        dateLabel.text = dateFormatter.stringFromDate(datePickers.date)
        
        if(todoItem.navigationTitle == "开始时间")
        {
            
            todoItem.startTime = time
            
        }
            
        else if(todoItem.navigationTitle == "结束时间")
        {
            
            todoItem.finishTime = time
            
        }
            
        else if(todoItem.navigationTitle == "提醒我")
        {
            datePickers.datePickerMode = .DateAndTime
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            time = dateFormatter.stringFromDate(datePickers.date)
            todoItem.reminderTime = time
            dateLabel.text = dateFormatter.stringFromDate(datePickers.date)
            
            //            self.scheduleLocalNotificationWithDate(datePickers.date)
            //            self.getAlertMessage("AlarmSet")
            
        }
        
    }
    
    @IBAction func finishAction(sender: UIButton) {
        
        finish()
        //用segue方式传值：如果是tableView 还可以传indexpath 过去。
        // self.performSegueWithIdentifier("mydateTable", sender: sender)
        
    }
    
    func finish()
    {
        if(todoItem.navigationTitle == "提醒我")
        {
            self.scheduleLocalNotificationWithDate(datePickers.date)
        }
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        SqliteHelper.updateData(.UpdateTodoList,model:todoItem)
        SqliteHelper.updateData(.UpdateTodoListItem,model:todoItem)
        self.taskInfoList.todoItem = todoItem
        self.navigationController?.popToViewController(self.taskInfoList, animated: true)
        
        //        self.navigationController?.popViewControllerAnimated(true)
        //        delegate?.showDate(time)
        
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getAlertMessage(message:String)
    {
        let alertView = UIAlertView(title: "Alarm Clock", message: message, delegate: self, cancelButtonTitle: "OK", otherButtonTitles: "", "")
        alertView.show()
        
    }
    
    func scheduleLocalNotificationWithDate(date:NSDate)
    {
        let notification = UILocalNotification()
        
        //        let fivesecond = NSDate(timeIntervalSinceNow: 5)
        //        notification.fireDate = fivesecond
        
        //        fivesecond.dateByAddingTimeInterval(4)
        
        //传类过去运行时会出错。 Property list invalid for format: 200 (property lists cannot contain objects of type 'CFType'
        
        var userDic  = ["timesup":"sai"]
        //        var dd = ["timesup":todoItem]
        
        let  currentTime = dateFormatter.stringFromDate(date)
        notification.fireDate = date
        notification.alertBody = "兄弟，出来行，迟早要把任务做完的。"
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.hasAction = true
        notification.alertAction = "SNOOZE"
        
        notification.userInfo = userDic
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        //notification.soundName = "Alarm.mp3"
        //        notification.alertAction = "Open"
        
        //        let state = UIApplication.sharedApplication().applicationState
        //        if (state == .Background)
        //        {
        //
        //            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        //        }
        
        
        //        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    /*
    func runTimer()
    {
    let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "showActivity", userInfo: nil, repeats: true)
    
    }
    
    func showActivity()
    {
    let date = NSDate()
    dateFormatter.timeStyle = .MediumStyle
    dateLabel.text = dateFormatter.stringFromDate(date)
    
    }
    */
}
