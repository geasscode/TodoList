//
//  TodoItemTableViewCell.swift
//  ToDoListApp
//
//  Created by phoenix on 11/13/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    struct Constants {
        static let maxProgress = 100
    }
    
    var hasFinish = false
    

    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    @IBOutlet weak var priority: UILabel!
    @IBOutlet weak var taskProgress: UIProgressView!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var emergencyStatus: UIImageView!
    
    let operationQueue = NSOperationQueue()
    
    
    var completedProgress: Int = 0 {
        didSet(oldValue) {
            let fractionalProgress = Float(completedProgress) / Float(Constants.maxProgress)
            
            let animated = oldValue != 0
            
            
            taskProgress.setProgress(fractionalProgress, animated: animated)
            
        }
    }
    
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
        
        NSNotificationCenter.defaultCenter().postNotificationName("hasFinish", object: sender)

    }
    
    func startAnimationWithDelay (delayTime: NSTimeInterval)
    {
        

    }
    
 
    
    func currentProgress(increase:Int) {
        
        operationQueue.addOperationWithBlock {
           // sleep(arc4random_uniform(10))
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.completedProgress = increase
                
                println("current progress value is \(self.completedProgress)")
                return
            }
        }
        
    }
    
}
