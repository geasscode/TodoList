//
//  SqliteHelper.swift
//  ToDoListApp
//
//  Created by desmond on 11/26/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class SqliteHelper: NSObject  {
    
    //只能操作不需要传入参数的sql。
    internal enum SqliteType: String {
        
        case InsertAllFromTodoList = "InsertAllFromTodoList"
        case InsertAllFromTodoListItem = "InsertAllFromTodoListItem"
        case QueryAllFromTodoList = "QueryAllFromTodoList"
        case QueryAllFromTodoListItem = "QueryAllFromTodoListItem"
        case QueryAllUndoTask = "QueryAllUndoTask"
        
        case QueryFinishedTask = "QueryFinishedTask"
        case QueryEmergencyTask = "QueryEmergencyTask"
        case QueryPriority = "QueryPriority"
        case QueryCreateDateTask = "QueryCreateDateTask"
        case QueryDeadLineTask = "QueryDeadLineTask"
        case QueryTodayTask = "QueryTodayTask"
        case QueryTomorrow = "QueryTomorrow"
        case QueryOneWeek = "QueryOneWeek"
        
        
        case UpdateTodoList = "UpdateTodoList"
        case UpdateTodoListItem = "UpdateTodoListItem"
        
    }
    //不需要传入参数的形式。
    internal enum sqlStatement: String {
        
        case QueryAllFromTodoList = "select * from TodoList"
        case QueryAllUndoTask = "select * from TodoList where HasTaskFinish = 0"
        case QueryDeadLineTask = "select * from TodoList ORDER BY  FinishTime DESC"
        case QueryCreateDateTask = "select * from TodoList ORDER BY  StartTime ASC"
        case QueryPriority = "select * from TodoList  ORDER BY(case  when Priority = '低' then 1 when Priority = '中' then 2 when Priority = '高' then 3 end) DESC"
        case QueryFinishedTask = "SELECT * FROM TodoList where HasTaskFinish = 1"
        case QueryEmergencyTask = "SELECT * FROM TodoList where Priority = '高'"
        case QueryTodayTask = "SELECT *  from TodoList where  date('now') = FinishTime"
        case QueryTomorrow = "SELECT * from TodoList where  date('now','+1 day') = FinishTime"
        case QueryOneWeek = "SELECT  * from TodoList where FinishTime BETWEEN date('now') AND date('now','+7 day')"
        
        
        
    }
    
    internal class func queryType(sqlType:SqliteType) -> [TodoList]
    {
        switch sqlType {
            
        case .QueryAllUndoTask:
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryAllUndoTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryCreateDateTask:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryCreateDateTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryDeadLineTask:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryDeadLineTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryEmergencyTask:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryEmergencyTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryPriority:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryPriority.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryFinishedTask:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryFinishedTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryTodayTask:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryTodayTask.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryTomorrow:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryTomorrow.rawValue)
            return  generateTodoList(resultSet, error: err)
            
        case .QueryOneWeek:
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryOneWeek.rawValue)
            return  generateTodoList(resultSet, error: err)
            
            
            
        default :
            return []
            
        }
    }
    
    internal class func generateTodoList(resultSet:[SwiftData.SDRow],error:Int?) -> [TodoList]
    {
        var todoListArray = [TodoList]()
        
        if error != nil {
            println("The error is \(error)")
            
        } else {
            for row in resultSet {
                var item = TodoList()
                
                if let taskId = row["TaskID"]?.asString() {
                    //                        println("The taskid  is: \(taskId)")
                    item.taskID = taskId
                    
                }
                
                if let taskname = row["TaskName"]?.asString() {
                    //                        println("The taskname name is: \(taskname)")
                    item.taskName = taskname
                    
                }
                if let emergency = row["Priority"]?.asString() {
                    item.currentPriority = emergency
                    //                        println("The emergency is: \(emergency)")
                }
                if let ischecked = row["IsChecked"]?.asBool() {
                    if ischecked {
                        item.hascomplete = ischecked
                        println("The task has finish")
                    } else {
                        println("The task must be  finish")
                    }
                }
                
                if let startTime = row["StartTime"]?.asString() {
                    item.startTime = startTime
                    
                }
                
                if let finishTime = row["FinishTime"]?.asString() {
                    item.finishTime = finishTime
                    //                        println("The task  was finish  at: \(finishTime)")
                }
                
                if let progress = row["Progress"]?.asString() {
                    item.currentProgress = progress
                    //                        println("The progress is : \(progress)")
                    
                }
                
                //没有添加这个字段导致 isNewTask 总为true，要小心不要漏了field
                if let isNewTask = row["IsNewTask"]?.asBool() {
                    item.isNewTask = isNewTask
                    //                        println("The isNewTask is : \(isNewTask)")
                    
                }
                
                if let hasTaskFinish = row["HasTaskFinish"]?.asBool() {
                    item.hasTaskfinish = hasTaskFinish
                    
                }
                
                todoListArray.append(item)
                
            }
        }
        return todoListArray
    }
    
    internal class func createTable()
    {
        
        //         if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT PRIMARY KEY , TaskName TEXT, Emergency TEXT, IsChecked BOOLEAN, FinishTime TEXT)") {
        println("start trying create TodoList table")
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoList (TaskID TEXT NOT NULL ,StartTime TEXT,TaskName TEXT NOT NULL, IsChecked BOOLEAN,Priority TEXT, FinishTime TEXT,Progress TEXT , IsNewTask  BOOLEAN, HasTaskFinish BOOLEAN, CONSTRAINT PK_TodoList PRIMARY KEY (TaskID))") {
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println("createTodoListSuccess")
            
        }
        
        
        //        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (ID INTEGER PRIMARY KEY AUTOINCREMENT, TaskName TEXT, Emergency TEXT, StartTime TEXT, FinishTime TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT)") {
        println("start trying create TodoListItem table")
        
        //TaskDescription TEXT, CONSTRAINT少了个逗号。调式了半天，要养成写调试信息的习惯。
        
        
        if let err = SD.executeChange("CREATE TABLE IF NOT EXISTS TodoListItem (TaskID TEXT NOT NULL ,TaskName TEXT NOT NULL, StartTime TEXT, FinishTime TEXT, ReminderMe TEXT,Priority TEXT,Progress TEXT,TaskDescription TEXT, CONSTRAINT PK_TodoListItem PRIMARY KEY (TaskID))") {
            
            //there was an error during this function, handle it here
            println(" error is \(err)")
            
        } else {
            
            println("createTodoListItemSuccess")
            
        }
        
    }
    //update跟select 一样麻烦先暂时简单的用着，以后慢慢增加功能。
    
    internal class func updateData(sqlType:SqliteType,model:TodoList)
    {
        println("start trying update TodoList table")
        
        let taskID = model.taskID
        let startTime = model.startTime
        let reminderMe = model.reminderTime
        let taskName = model.taskName
        let priority = model.currentPriority
        let finishTime = model.finishTime
        let progress = model.currentProgress
        let remark = model.remarks
        let hasFinish = model.hasTaskfinish
        switch sqlType {
            
        case .UpdateTodoList:
            let (resultSet, err) = SD.executeQuery("UPDATE TodoList set TaskName = ?,StartTime = ?, FinishTime = ?,Priority = ?, Progress = ?,HasTaskFinish = ? WHERE TaskID = ?", withArgs: [taskName,startTime,finishTime,priority,progress,hasFinish,taskID])
            println(" update TodoList table success")
            
        case .UpdateTodoListItem:
            //?和argument应该是一一对应的。顺序不能乱。
            let (resultSet2, err2) = SD.executeQuery("UPDATE TodoListItem set TaskName = ?,StartTime = ?, FinishTime = ?,Priority = ?, ReminderMe = ?,Progress = ?, TaskDescription = ? WHERE TaskID = ?", withArgs: [taskName,startTime,finishTime,priority,reminderMe,progress,remark,taskID])
            
            println(" update TodoListItem table success")
            
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
        let reminderMe:String = model.reminderTime
        let hasTaskFinish:Bool = model.hasTaskfinish
        
        
        
        
        switch sqlType {
            
        case .InsertAllFromTodoList:
            
            println( "start trying insert todoList ...")
            
            if let err = SD.executeChange("INSERT INTO TodoList (TaskID,TaskName,StartTime, Priority, IsChecked, FinishTime,Progress,IsNewTask,HasTaskFinish) VALUES (?, ?, ?,?, ?, ?,?,?,?)", withArgs: [taskID,taskName,startTime, priority, isChecked, finishTime,progress,isNewTask,hasTaskFinish]) {
                //there was an error during the insert, handle it here
                println( "error is \(err)")
                
            } else {
                println( "insert todoList success")
                
            }
            
        case .InsertAllFromTodoListItem:
            
            println( "start trying insert todoListItem ...")
            
            if let err = SD.executeChange("INSERT INTO TodoListItem (TaskID,TaskName, StartTime, FinishTime,ReminderMe,Priority,Progress,TaskDescription) VALUES (?,?, ?, ?, ?, ?,?,?)", withArgs: [taskID,taskName, startTime , finishTime,reminderMe,priority,progress,taskDescription]) {
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
            
            println( "start trying query todoList ...")
            
            let (resultSet, err) = SD.executeQuery(sqlStatement.QueryAllFromTodoList.rawValue)
            return  generateTodoList(resultSet, error: err)
            /*
            let (resultSet, err2) = SD.executeQuery("SELECT * FROM TodoList")
            
            if err2 != nil {
            println("The error is \(err2)")
            
            } else {
            for row in resultSet {
            var item = TodoList()
            
            if let taskId = row["TaskID"]?.asString() {
            //                        println("The taskid  is: \(taskId)")
            item.taskID = taskId
            
            }
            
            if let taskname = row["TaskName"]?.asString() {
            //                        println("The taskname name is: \(taskname)")
            item.taskName = taskname
            
            }
            if let emergency = row["Priority"]?.asString() {
            item.currentPriority = emergency
            //                        println("The emergency is: \(emergency)")
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
            //                        println("The task  was finish  at: \(finishTime)")
            }
            
            if let progress = row["Progress"]?.asString() {
            item.currentProgress = progress
            //                        println("The progress is : \(progress)")
            
            }
            
            //没有添加这个字段导致 isNewTask 总为true，要小心不要漏了field
            if let isNewTask = row["IsNewTask"]?.asBool() {
            item.isNewTask = isNewTask
            //                        println("The isNewTask is : \(isNewTask)")
            
            }
            
            if let hasTaskFinish = row["HasTaskFinish"]?.asBool() {
            item.hasTaskfinish = hasTaskFinish
            
            }
            
            
            todoListArray.append(item)
            println( "query todoList  success...")
            
            }
            }
            */
        case .QueryAllFromTodoListItem :
            let (resultSet, err) = SD.executeQuery("SELECT * from TodoListItem")
            
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
                    
                    if let taskDescription = row["TaskDescription"]?.asString() {
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
    
    
    internal class func queryDataWithField(item:TodoList) -> TodoList
    {
        println( "start trying query todoListItem ...")
        
        let (resultSet, err) = SD.executeQuery("SELECT * FROM TodoListItem where TaskName = ?",withArgs:[item.taskName])
        
        
        if err != nil {
            println("The QueryWithKeyFromTodoListItem error is \(err)")
            
        } else {
            for row in resultSet {
                
                
                
                if let taskname = row["TaskName"]?.asString() {
                    //                    println("The taskname name is: \(taskname)")
                    item.taskName = taskname
                    
                }
                
                
                
                if let startTime = row["StartTime"]?.asString() {
                    item.startTime = startTime
                    
                }
                
                if let finishTime = row["FinishTime"]?.asString() {
                    item.finishTime = finishTime
                    
                }
                //蛋疼字段写成小写。导致发现不了问题。
                if let reminderMe = row["ReminderMe"]?.asString() {
                    item.reminderTime = reminderMe
                    
                }
                
                
                if let emergency = row["Priority"]?.asString() {
                    item.currentPriority = emergency
                    
                }
                
                if let progress = row["Progress"]?.asString() {
                    item.currentProgress = progress
                    
                }
                
                if let taskDescription = row["TaskDescription"]?.asString() {
                    item.remarks = taskDescription
                    
                }
                
                if let hasTaskFinish = row["HasTaskFinish"]?.asBool() {
                    item.hasTaskfinish = hasTaskFinish
                    
                }
                
                
            }
        }
        println( " query todoListItem success ...")
        
        return item
        
    }
    
    internal class func deleteTodoList(deleteByKey:String)
    {
        let (resultSet2, err2) = SD.executeQuery("DELETE FROM TodoList WHERE TaskID = ?", withArgs: [deleteByKey])
        
    }
    
    internal class func deleteTodoListItem(deleteByKey:String)
    {
        let (resultSet2, err2) = SD.executeQuery("DELETE FROM TodoListItem WHERE TaskID = ?", withArgs: [deleteByKey])
        
    }
    
}
