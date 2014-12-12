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

class TodoList  {
    
    var taskID = ""
    var taskName = ""
    var desc = ""
    var hascomplete = false
    var startTime = ""
    var finishTime = ""
    var remarks = "任务描述"
    var navigationTitle = ""
    var hasTaskfinish = false
    var currentPriority = "低"
    var currentProgress = "0%"
    var reminderTime = ""
    var isNewTask = true
    var currentRow  = 0
    var isShortcut = false

}



  class TodoHelper: NSObject {
    
    struct TabBarIndex {
        static var currentIndex = 0
    }
    var currentTodo = TodoList()

}
