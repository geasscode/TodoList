//
//  TodoListHelper.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

private let _singletonInstance = SingletonClass()
class SingletonClass {
    class var sharedInstance: SingletonClass {
        return _singletonInstance
    }
    var todoList = todoListHelper.lists
    
}


var todoListHelper : TodoHelper = TodoHelper ()

class TodoList {
    var name = ""
    var desc = ""
    var hascomplete = false
    var startTime = ""
    var finishTime = ""
    var remarks = ""
    var navigationTitle = ""
    var taskfinish = false
    
    init()
    {
        
    }
    init(name:String,desc:String,hascomplete:Bool)
        
    {
        self.name = name
        self.desc = desc
        self.hascomplete = hascomplete
    }
}



class TodoHelper: NSObject {
    
    //    var hascomplete = false
    var currentTodo = TodoList()

    var lists = [TodoList]()
    
    func addTask(name: String, desc: String,complete:Bool) {
        
        lists.append(TodoList(name: name, desc: desc,hascomplete:complete))
    }
    
    
    
    
    
}
