//
//  TodoItemTableViewCell.swift
//  ToDoListApp
//
//  Created by phoenix on 11/13/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var checkbox: UIButton!

    @IBOutlet weak var taskProgress: UIProgressView!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var emergencyStatus: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkbox.setImage(UIImage(named: "icon_checkbox_default.png"), forState: UIControlState.Normal)

        checkbox.setImage(UIImage(named: "icon_checkbox_selected.png"), forState: UIControlState.Selected)

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkboxStatus(sender: UIButton) {
        checkbox.selected = !sender.selected;
        
        
//        checkbox.imageView?.image = UIImage(named: "icon_checkbox_selected.png")
        
        todoListHelper.currentTodo.taskfinish = true
    }
}
