//
//  HeaderVC.swift
//  ToDoListApp
//
//  Created by phoenix on 11/13/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController {
    
    
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
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        println(textField.text)
    }
    
    
    func textViewShouldBeginEditing(textField: UITextField!) -> Bool {
        println("textViewShouldBeginEditing")
        return true
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
