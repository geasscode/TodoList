//
//  UserAddVC.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class UserAddVC:UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var toDoListTitle: UITextField!
    
    @IBOutlet weak var desc: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    @IBAction func addText(sender: AnyObject) {
        
        todoListHelper.addTask(toDoListTitle.text, desc: desc.text,complete:false)
//        SingletonClass.sharedInstance.todoList = todoListHelper.lists
        let list = todoListHelper.lists


        //todoListHelper.addTask(toDoListTitle.text, desc: desc.text)
        self.view.endEditing(true)
        toDoListTitle.text = ""
        desc.text = ""
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
