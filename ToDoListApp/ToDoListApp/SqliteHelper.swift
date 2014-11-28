//
//  SqliteHelper.swift
//  ToDoListApp
//
//  Created by desmond on 11/26/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class SqliteHelper: NSObject  {
    
    var todoListArray = [TodoList]()

  internal class func createTable()
    {
        
       
//         if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT PRIMARY KEY , TaskName TEXT, Emergency TEXT, IsChecked BOOLEAN, FinishTime TEXT)") {
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT NOT NULL ,TaskName TEXT NOT NULL, Emergency TEXT, IsChecked BOOLEAN, FinishTime TEXT,CONSTRAINT PK_TodoList PRIMARY KEY (TaskID),CONSTRAINT FK_TodoListItem FOREIGN KEY (TaskID) REFERENCES TodoListItem(TaskID))") {
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println("no error.")
            
        }
        
        
//        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (ID INTEGER PRIMARY KEY AUTOINCREMENT, TaskName TEXT, Emergency TEXT, StartTime TEXT, FinishTime TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT)") {
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (TaskID TEXT NOT NULL ,TaskName TEXT NOT NULL, Emergency TEXT, StartTime TEXT, FinishTime TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT,CONSTRAINT PK_TodoList PRIMARY KEY (TaskID))") {
            
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println(" no error ")
            
        }
        
    }
    //update跟select 一样麻烦先暂时简单的用着，以后慢慢增加功能。
    
   internal class func updateData()
    {
    
    let taskName = "hello,world"
    let emergency = "!!"
        let (resultSet2, err2) = SD.executeQuery("UPDATE TodoList set  TaskName WHERE Emergency = ?", withArgs: [taskName,emergency])

    }
    
    
   internal class func insertData(item:String)(todolistItem:TodoList)
    {
        let item = item
        //        let todolistItem = item as TodoList
        let startTime:String = todolistItem.startTime
        let taskID: String = todolistItem.taskID
        let taskName: String = todolistItem.taskName
        let emergency: String = todolistItem.currentPriority
        let isChecked: Bool = todolistItem.hascomplete
        let finishTime: String =  todolistItem.finishTime
        let progress :String = todolistItem.currentProgress
        let taskDescription:String = todolistItem.remarks
        
        if let err = SD.executeChange("INSERT INTO TodoList (TaskID,TaskName, Emergency, IsChecked, FinishTime) VALUES (?, ?, ?, ?, ?)", withArgs: [taskID,taskName, emergency, isChecked, finishTime]) {
            //there was an error during the insert, handle it here
            println( "error is \(err)")
            
        } else {
            println( "insert success")
            
        }
        
   
//        if let err = SD.executeChange("INSERT INTO TodoListItem (TaskID,TaskName, Emergency, StartTime, FinishTime,Priority,Progress,TaskDescription) VALUES (?, ?, ?, ?, ?,?,?,?)", withArgs: [taskID,taskName, emergency, startTime , finishTime,emergency,progress,taskDescription]) {
//            //there was an error during the insert, handle it here
//            println( "error is \(err)")
//            
//        } else {
//            println( "insert success")
//            
//        }
    }
    

   func queryData(queryDataWithKey:String) -> [TodoList]
    {

        let (resultSet, err2) = SD.executeQuery("SELECT * FROM TodoList")

//        let (resultSet, err2) = SD.executeQuery("SELECT * FROM TodoList WHERE TaskName = ? ", withArgs: [queryDataWithKey])
        if err2 != nil {
            println("The error is \(err2)")
            
        } else {
            for row in resultSet {
                //位置放错，导致生成的是同一个。
                var item = TodoList()

                if let taskId = row["TaskID"]?.asString() {
                    println("The taskid  is: \(taskId)")
                    item.taskID = taskId
                    
                }

                if let taskname = row["TaskName"]?.asString() {
                    println("The taskname name is: \(taskname)")
                    item.taskName = taskname
                    
                }
                if let emergency = row["Emergency"]?.asString() {
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
                todoListArray.append(item)

            }
        }
        return (todoListArray)

//        let (resultSet, errs) = SD.executeQuery("SELECT * FROM TodoList")
//        if errs != nil {
//            println(" error is \(errs)")
//            
//        } else {
//            for row in resultSet {
//                if let taskname = row["TaskName"]?.asString() {
//                    println("The taskname name is: \(taskname)") //should be "Toronto"
//                }
//                if let emergency = row["Emergency"]?.asString() {
//                    println("The emergency is: \(emergency)")
//                }
//                if let ischecked = row["IsChecked"]?.asBool() {
//                    if ischecked {
//                        println("The task has finish")
//                    } else {
//                        println("The task must be  finish")
//                    }
//                }
//                if let finishTime = row["FinishTime"]?.asString() {
//                    println("The task  was finish  at: \(finishTime)")
//                }
//            }
//        }
        
    }
    
    
    func queryDatas(queryDataWithKey:String) -> [TodoList]
    {
        
        let (resultSet, err2) = SD.executeQuery("SELECT * FROM TodoListItem")
        
        if err2 != nil {
            println("The error is \(err2)")
            
        } else {
            for row in resultSet {
                
               // INSERT INTO TodoListItem (TaskID,TaskName, Emergency, StartTime, FinishTime,Priority,Progress,TaskDescription)
                //位置放错，导致生成的是同一个。
                var item = TodoList()
                
                if let taskId = row["TaskID"]?.asString() {
                    println("The taskid  is: \(taskId)")
                    item.taskID = taskId
                    
                }
                
                if let taskname = row["TaskName"]?.asString() {
                    println("The taskname name is: \(taskname)")
                    item.taskName = taskname
                    
                }
                if let emergency = row["Emergency"]?.asString() {
                    item.currentPriority = emergency
                    println("The emergency is: \(emergency)")
                }
                
                if let finishTime = row["FinishTime"]?.asString() {
                    item.finishTime = finishTime
                    println("The task  was finish  at: \(finishTime)")
                }
                
                if let priority = row["Priority"]?.asString() {
                    item.currentPriority = priority
                    println("The task  was currentPriority  at: \(priority)")
                }
                
                if let progress = row["Progress"]?.asString() {
                    item.currentProgress = progress
                    println("The task  was Progress  at: \(progress)")
                }
                
                if let taskDescription = row["TaskDescription"]?.asString() {
                    item.remarks = taskDescription
                    println("The task  was Progress  at: \(taskDescription)")
                }

                
                todoListArray.append(item)
                
            }
        }
        return (todoListArray)
    }
    
   internal class func deleteData(deleteByKey:String)
    {
        let (resultSet2, err2) = SD.executeQuery("DELETE FROM TodoList WHERE TaskID = ?", withArgs: [deleteByKey])

    }
    
}
