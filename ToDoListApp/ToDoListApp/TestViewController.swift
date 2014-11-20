//
//  TestViewController.swift
//  ToDoListApp
//
//  Created by phoenix on 11/20/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var testDelete: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let buttonTitle = NSLocalizedString("Button", comment: "")
        
        // Set the button's title for normal state.
        let normalTitleAttributes = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
        ]
        
        
        let normalAttributedTitle = NSAttributedString(string: "helloworld", attributes: normalTitleAttributes)
        testDelete.attributedText = normalAttributedTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
//    attributedTextButton.setAttributedTitle(normalAttributedTitle, forState: .Normal)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
