//
//  TodoListCheckCell.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListCheckCell: TodoListBaseCell {
    
    
    override func configure() {
        super.configure()
        selectionStyle = .Default
        accessoryType = .None
    }
    
    override func update() {
        super.update()
        textLabel.text = rowDescriptor.title
        
        if rowDescriptor.value == nil {
            rowDescriptor.value = false
        }
        
        accessoryType = (rowDescriptor.value as Bool) ? .Checkmark : .None
    }
    

    override class func todoListViewController(todoListViewController: TodoListTableViewController, didSelectRow selectedRow: TodoListBaseCell) {
        
        if let row = selectedRow as? TodoListCheckCell {
            row.check()
        }
    }
    
    
    private func check() {
        if rowDescriptor.value != nil {
            rowDescriptor.value = !(rowDescriptor.value as Bool)
        }
        else {
            rowDescriptor.value = true
        }
        accessoryType = (rowDescriptor.value as Bool) ? .Checkmark : .None
    }

   
}
