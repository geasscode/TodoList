//
//  HeaderVC.swift
//  ToDoListApp
//
//  Created by phoenix on 11/13/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var newTask: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置了delegate crash 不知道神马原因。
        //newTask.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //    }
    //
    //    required init(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    /*
    optional func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
    optional func textFieldDidBeginEditing(textField: UITextField) // became first responder
    optional func textFieldShouldEndEditing(textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    optional func textFieldDidEndEditing(textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    optional func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    
    optional func textFieldShouldClear(textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    optional func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    */
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        NSNotificationCenter.defaultCenter().postNotificationName("taskName", object: textField)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        println(textField.text)
    }
    
    
     func textFieldShouldBeginEditing(textField: UITextField) -> Bool  {
        println("textViewShouldBeginEditing")
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        println("textFieldDidBeginEditing")

    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        println("textFieldDidEndEditing")

    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
