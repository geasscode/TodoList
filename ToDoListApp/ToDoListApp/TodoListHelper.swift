//
//  TodoListHelper.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

//private let _singletonInstance = SingletonClass()
//class SingletonClass {
//    class var sharedInstance: SingletonClass {
//        return _singletonInstance
//    }
//    var todoList = todoListHelper.lists
//    
//}


var todoListHelper  = TodoHelper ()

class TodoList {
    var taskID = ""
    var taskName = ""
    var desc = ""
    var hascomplete = false
    var startTime = ""
    var finishTime = ""
    var remarks = ""
    var navigationTitle = ""
    var taskfinish = false
    var currentPriority = ""
    var currentProgress = ""
    var reminderTime = ""
    var isNewTask = false
    var currentRow  = 0
    
//    init()
//    {
//        
//    }
//    
//    init(taskName:String,finishTime:String,hascomplete:Bool)
//        
//    {
//        self.taskName = taskName
//        self.finishTime  = finishTime
//        self.hascomplete = hascomplete
//    }
}



  class TodoHelper: NSObject {
    
   
    
//    var lists = [TodoList]()

    //    var hascomplete = false
    var currentTodo = TodoList()

    
//    func addTask(taskName: String, dateline: String,complete:Bool) {
//        lists.append(TodoList(taskName: taskName, finishTime: dateline,hascomplete:complete))
//
//        
//        //lists.append(TodoList(name: name, desc: desc,hascomplete:complete))
//    }
    
//    func addTask(item:TodoList) {
//
////        lists.append(item)
//        lists.append(item)
//
//        
//        println("the item is \(item)")
//        //lists.append(TodoList(name: name, desc: desc,hascomplete:complete))
//    }
    
    
    
    
}
