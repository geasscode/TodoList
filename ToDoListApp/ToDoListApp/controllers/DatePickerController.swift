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
class DatePickerController: UIViewController {
    
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
//        let title = todoListHelper.currentTodo
//        navigationItem.title = todoListHelper.currentTodo.navigationTitle
        
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
        
        dateLabel.text = dateFormatter.stringFromDate(datePickers.date)
        
        
        time = dateFormatter.stringFromDate(datePickers.date)
        //        todoListHelper.currentTodo.finishTime = time
        println("currentTime is \(time)")
        
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        //        let formatTime = dateFormatter.stringFromDate(datePickers.date)
        //        println("currentFormatterTime is \(time)")
        
    }
    
    @IBAction func finishAction(sender: UIButton) {
        
        finish()
        //用segue方式传值：如果是tableView 还可以传indexpath 过去。
       // self.performSegueWithIdentifier("mydateTable", sender: sender)
        
    }
    
    func finish()
    {
        
        if(todoItem.navigationTitle == "开始时间")
        {
           todoItem.startTime = time
            //            dateTable.currentTodo.startTime = time
            
        }
        else if(todoItem.navigationTitle == "结束时间")
        {
            todoItem.finishTime = time
            
        }
        
        else
        {
            todoItem.reminderTime = time
        }

        //        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    
    
    
}
