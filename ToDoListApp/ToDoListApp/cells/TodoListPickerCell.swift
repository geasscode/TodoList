//
//  TodoListPickerCell.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListPickerCell: TodoListBaseCell, UIPickerViewDelegate, UIPickerViewDataSource {

   
    private let hiddenTextField = UITextField(frame: CGRectZero)
    private let picker = UIPickerView()
    
    
    override func configure() {
        super.configure()
        contentView.addSubview(hiddenTextField)
        picker.delegate = self
        picker.dataSource = self
        hiddenTextField.inputView = picker
    }
    
    override func update() {
        super.update()
        textLabel?.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            detailTextLabel?.text = rowDescriptor.titleForOptionValue(rowDescriptor.value)
        }
    }

    override class func todoListViewController(todoListViewController: TodoListTableViewController, didSelectRow selectedRow: TodoListBaseCell) {
        
        if selectedRow.rowDescriptor.value == nil {
            if let row = selectedRow as? TodoListPickerCell {
                let optionValue = selectedRow.rowDescriptor.options[0]
                selectedRow.rowDescriptor.value = optionValue
                selectedRow.detailTextLabel?.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue)
                row.hiddenTextField.becomeFirstResponder()
            }
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return rowDescriptor.titleForOptionAtIndex(row)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let optionValue = rowDescriptor.options[row]
        rowDescriptor.value = optionValue
        detailTextLabel?.text = rowDescriptor.titleForOptionValue(optionValue)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowDescriptor.options.count
    }


}
