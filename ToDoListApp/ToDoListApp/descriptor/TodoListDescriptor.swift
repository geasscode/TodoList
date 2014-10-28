//
//  TodoListDescriptor.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListDescriptor: NSObject {
    
    var title: String!
    
    var sections: [TodoListSectionDescriptor] = []
    
    /// MARK: Public interface
    
    func addSection(section: TodoListSectionDescriptor) {
        sections.append(section)
    }
    
    func removeSection(section: TodoListSectionDescriptor) {
        if let index = find(sections, section) {
            sections.removeAtIndex(index)
        }
    }
    
    func formValues() -> Dictionary<String, NSObject> {
        
        var formValues: Dictionary<String, NSObject> = [:]
        
        for section in sections {
            for row in section.rows {
                if row.tag != nil && row.rowType != .Button {
                    if row.value != nil {
                        formValues[row.tag!] = row.value!
                    }
                    else {
                        formValues[row.tag!] = NSNull()
                    }
                }
            }
        }
        return formValues
    }

   
}
