//
//  SqliteHelper.swift
//  ToDoListApp
//
//  Created by desmond on 11/26/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class SqliteHelper: NSObject  {
    
    internal enum SqliteType: String {
        
        case InsertAllFromTodoList = "InsertAllFromTodoList"
        case InsertAllFromTodoListItem = "InsertAllFromTodoListItem"
        case QueryAllFromTodoList = "QueryAllFromTodoList"
        case QueryWithKeyFromTodoListItem = "QueryWithKeyFromTodoListItem"
        case UpdateTodoList = "UpdateTodoList"
        case UpdateTodoListItem = "UpdateTodoListItem"
        
    }
    
    
    
    internal class func createTable()
    {
        
        
        //         if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT PRIMARY KEY , TaskName TEXT, Emergency TEXT, IsChecked BOOLEAN, FinishTime TEXT)") {
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT NOT NULL ,TaskName TEXT NOT NULL, IsChecked BOOLEAN,Priority TEXT, FinishTime TEXT,Progress TEXT , IsNewTask  BOOLEAN, CONSTRAINT PK_TodoList PRIMARY KEY (TaskID),CONSTRAINT FK_TodoListItem FOREIGN KEY (TaskName) REFERENCES TodoListItem(TaskName))") {
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println("no error.")
            
        }
        
        
        //        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (ID INTEGER PRIMARY KEY AUTOINCREMENT, TaskName TEXT, Emergency TEXT, StartTime TEXT, FinishTime TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT)") {
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (TaskName TEXT NOT NULL, StartTime TEXT, FinishTime TEXT, ReminderMe TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT,CONSTRAINT PK_TodoListItem PRIMARY KEY (TaskName))") {
            
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println(" no error ")
            
        }
        
    }
    //update跟select 一样麻烦先暂时简单的用着，以后慢慢增加功能。
    
    internal class func updateData(sqlType:SqliteType,model:TodoList)
    {
        let startTime = model.startTime
        let reminderMe = model.reminderTime
        let taskName = model.taskName
        let priority = model.currentPriority
        let finishTime = model.finishTime
        let progress = model.currentProgress
        let remark = model.remarks
        
        switch sqlType {
            
        case .UpdateTodoList:
            let (resultSet, err) = SD.executeQuery("UPDATE TodoList set  FinishTime = ?,Priority = ?, Progress = ? WHERE TaskName = ?", withArgs: [finishTime,priority,progress,taskName])
        case .UpdateTodoListItem:
            let (resultSet2, err2) = SD.executeQuery("UPDATE TodoListItem set StartTime = ?, FinishTime = ?,Priority = ?, ReminderMe = ?,Progress = ? WHERE TaskName = ?", withArgs: [startTime,finishTime,priority,progress,reminderMe,taskName])
        default :
            println("")
            
        }
    }
    
    //internal class func insertData(item:String)(todolistItem:TodoList)
    
    internal class func insertData(sqlType:SqliteType,model:TodoList)
    {
        
        //        let todolistItem = item as TodoList
        let startTime:String = model.startTime
        let taskID: String = model.taskID
        let taskName: String = model.taskName
        let priority: String = model.currentPriority
        let isChecked: Bool = model.hascomplete
        let finishTime: String =  model.finishTime
        let progress :String = model.currentProgress
        let taskDescription:String = model.remarks
        let isNewTask:Bool = model.isNewTask
        
        
        
        switch sqlType {
            
        case .InsertAllFromTodoList:
            
            println( "start trying insert todoList ...")

            if let err = SD.executeChange("INSERT INTO TodoList (TaskID,TaskName, Priority, IsChecked, FinishTime,Progress,IsNewTask) VALUES (?, ?, ?, ?, ?,?,?)", withArgs: [taskID,taskName, priority, isChecked, finishTime,progress,isNewTask]) {
                //there was an error during the insert, handle it here
                println( "error is \(err)")
                
            } else {
                println( "insert todoList success")
                
            }
            
        case .InsertAllFromTodoListItem:
            
            println( "start trying insert todoListItem ...")

            if let err = SD.executeChange("INSERT INTO TodoListItem (TaskName, StartTime, FinishTime,Priority,Progress,TaskDescription) VALUES (?, ?, ?, ?, ?,?)", withArgs: [taskName, startTime , finishTime,priority,progress,taskDescription]) {
                //there was an error during the insert, handle it here
                println( "error is \(err)")
                
            } else {
                println( "insert todolistItem success")
                
            }
            
        default :
            return
            
        }
        
        
    }
    
    
    
    
    internal class func queryData(sqliteType:SqliteType) -> [TodoList]
    {
        var todoListArray = [TodoList]()
        
        switch(sqliteType)
        {
            
        case .QueryAllFromTodoList:
            
            let (resultSet, err2) = SD.executeQuery("SELECT * FROM TodoList")
            
            if err2 != nil {
                println("The error is \(err2)")
                
            } else {
                for row in resultSet {
                    var item = TodoList()
                    
                    if let taskId = row["TaskID"]?.asString() {
                        println("The taskid  is: \(taskId)")
                        item.taskID = taskId
                        
                    }
                    
                    if let taskname = row["TaskName"]?.asString() {
                        println("The taskname name is: \(taskname)")
                        item.taskName = taskname
                        
                    }
                    if let emergency = row["Priority"]?.asString() {
                        item.currentPriority = emergency
                        println("The emergency is: \(emergency)")
                    }
                    if let ischecked = row["IsChecked"]?.asBool() {
                        if ischecked {
                            item.hascomplete = ischecked
                            println("The task has finish")
                        } else {
                            println("The task must be  finish")
                        }
                    }
                    if let finishTime = row["FinishTime"]?.asString() {
                        item.finishTime = finishTime
                        println("The task  was finish  at: \(finishTime)")
                    }
                    
                    if let progress = row["Progress"]?.asString() {
                        item.currentProgress = progress
                        println("The progress is : \(progress)")
                        
                    }
                    
                    //没有添加这个字段导致 isNewTask 总为true，要小心不要漏了field
                    if let isNewTask = row["IsNewTask"]?.asBool() {
                        item.isNewTask = isNewTask
                        println("The isNewTask is : \(isNewTask)")
                        
                    }
                    
                    
                    todoListArray.append(item)
                    
                }
            }
            
        case .QueryWithKeyFromTodoListItem :
            let (resultSet, err) = SD.executeQuery("SELECT item.TaskName,StartTime,item.FinishTime,ReminderMe,item.Priority,item.Progress,TaskDescription FROM TodoListItem item,TodoList todo where item.TaskName = todo.TaskName")
            
            if err != nil {
                println("The QueryWithKeyFromTodoListItem error is \(err)")
                
            } else {
                for row in resultSet {
                    
                    var item = TodoList()
                    
                    if let taskname = row["TaskName"]?.asString() {
                        println("The taskname name is: \(taskname)")
                        item.taskName = taskname
                        
                    }
                    
                    
                    
                    if let startTime = row["StartTime"]?.asString() {
                        item.startTime = startTime
                        
                    }
                    
                    if let finishTime = row["FinishTime"]?.asString() {
                        item.finishTime = finishTime
                        
                    }
                    
                    if let reminderMe = row["reminderMe"]?.asString() {
                        item.reminderTime = reminderMe
                        
                    }
                    
                    
                    if let emergency = row["Priority"]?.asString() {
                        item.currentPriority = emergency
                        
                    }
                    
                    if let progress = row["Progress"]?.asString() {
                        item.currentProgress = progress
                        
                    }
                    
                    if let taskDescription = row["taskDescription"]?.asString() {
                        item.remarks = taskDescription
                        
                    }
                    todoListArray.append(item)
                    
                }
            }
            
            
        default :
            println("")
        }
        
        return todoListArray
        
    }
    
    
    internal class func queryDataWithField(sqliteType:SqliteType) -> TodoList
    {
        var item = TodoList()
        
        let (resultSet, err) = SD.executeQuery("SELECT item.TaskName,StartTime,item.FinishTime,ReminderMe,item.Priority,item.Progress,TaskDescription FROM TodoListItem item,TodoList todo where item.TaskName = todo.TaskName")
        
        if err != nil {
            println("The QueryWithKeyFromTodoListItem error is \(err)")
            
        } else {
            for row in resultSet {
                
                
                
                if let taskname = row["TaskName"]?.asString() {
                    println("The taskname name is: \(taskname)")
                    item.taskName = taskname
                    
                }
                
                
                
                if let startTime = row["StartTime"]?.asString() {
                    item.startTime = startTime
                    
                }
                
                if let finishTime = row["FinishTime"]?.asString() {
                    item.finishTime = finishTime
                    
                }
                
                if let reminderMe = row["reminderMe"]?.asString() {
                    item.reminderTime = reminderMe
                    
                }
                
                
                if let emergency = row["Priority"]?.asString() {
                    item.currentPriority = emergency
                    
                }
                
                if let progress = row["Progress"]?.asString() {
                    item.currentProgress = progress
                    
                }
                
                if let taskDescription = row["taskDescription"]?.asString() {
                    item.remarks = taskDescription
                    
                }
                
            }
        }
        return item
    }
    
    internal class func deleteData(deleteByKey:String)
    {
        let (resultSet2, err2) = SD.executeQuery("DELETE FROM TodoList WHERE TaskID = ?", withArgs: [deleteByKey])
        
    }
    
}
