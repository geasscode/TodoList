//
//  TodoListBaseCell.swift
//  ToDoListApp
//
//  Created by desmond on 10/28/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoListBaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var rowDescriptor: TodoListRowDescriptor! {
        didSet {
            self.update()
        }
    }
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configure() {
        /// override
    }
    
    func update() {
        /// override
    }
    
    class func todoListRowCellHeight() -> CGFloat {
        return 44.0
    }
    
    class func todoListViewController(todoListViewController: TodoListTableViewController, didSelectRow: TodoListBaseCell) {
    }


}
