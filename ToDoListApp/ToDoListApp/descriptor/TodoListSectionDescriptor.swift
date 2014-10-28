//
//  TodoListSectionDescriptor.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListSectionDescriptor: NSObject {
    
    var headerTitle: String!
    var footerTitle: String!
    
    var rows: [TodoListRowDescriptor] = []
    
    /// MARK: Public interface
    
    func addRow(row: TodoListRowDescriptor) {
        rows.append(row)
    }
    
    func removeRow(row: TodoListRowDescriptor) {
        if let index = find(rows, row) {
            rows.removeAtIndex(index)
        }
    }

   
}
