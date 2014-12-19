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

extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

//多optional 情况下可用的方法
func unwrap<T1, T2>(optional1: T1?, optional2: T2?) -> (T1, T2)? {
    switch (optional1, optional2) {
    case let (.Some(value1), .Some(value2)):
        return (value1, value2)
    default:
        return nil
    }
}

func unwrap<T1, T2, T3>(optional1: T1?, optional2: T2?, optional3: T3?) -> (T1, T2, T3)? {
    switch (optional1, optional2, optional3) {
    case let (.Some(value1), .Some(value2), .Some(value3)):
        return (value1, value2, value3)
    default:
        return nil
    }
}

func unwrap<T1, T2, T3, T4>(optional1: T1?, optional2: T2?, optional3: T3?, optional4: T4?) -> (T1, T2, T3, T4)? {
    switch (optional1, optional2, optional3, optional4) {
    case let (.Some(value1), .Some(value2), .Some(value3), .Some(value4)):
        return (value1, value2, value3, value4)
    default:
        return nil
    }
}

//例子：
/*
if let (firstName, lastName) = unwrap(optionalFirstName, optionalLastName) {
    println("Hello \(firstName) \(lastName)!")
}



switch (optionalFirstName, optionalLastName) {
case let (.Some(firstName), .Some(lastName)):
    println("Hello \(firstName) \(lastName)!")
case let (.Some(firstName), .None):
    println("Hi \(firstName)!")
case let (.None, .Some(lastName)):
    println("Greetings \(lastName).")
case let (.None, .None):
    println("Good day to you!")
}
*/

//var todoListHelper  = TodoHelper ()

class TodoList : NSObject  {
    
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
        static var selectedSearchTab = false
        static var isFirestCreateTable = true
    }
//    var currentTodo = TodoList()

}
