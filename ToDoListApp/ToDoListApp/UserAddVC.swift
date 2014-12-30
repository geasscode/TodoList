//
//  UserAddVC.swift
//  TodoList
//
//  Created by desmond on 10/27/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class UserAddVC:UIViewController, UITextFieldDelegate,IGLDropDownMenuDelegate {
    
    @IBOutlet weak var cardView: UIView!
    
//    @IBOutlet weak var toDoListTitle: UITextField!
//    
//    @IBOutlet weak var desc: UITextView!
      var dropDownMenu = IGLDropDownMenu()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
       
        showDropDownList()
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func dropDownMenu(dropDownMenu:IGLDropDownMenu, selectedItemAtIndex index:Int)
    {
        var item = dropDownMenu.dropDownItems[index] as IGLDropDownItem
    }
    
    func showDropDownList()
    {
        var dataArray = [["image":"sun.png","title":"Sun"],["image":"clouds.png","title":"Clouds"],["image":"rain.png","title":"Rain"],["image":"clouds.png","title":"Clouds"]]
        
        var dropdownItems:NSMutableArray = []
        
        for var i = 0 ;i<dataArray.count;i++
        {
            var dict = dataArray[i]
            var dropDownItem = IGLDropDownItem()
            
            //            dropDownItem.setIconImages(UIImage(named: dict["image"]!))
            
            if let image = dict["image"]
            {
                dropDownItem.setIconImages(UIImage(named: image))

            }
            let value = dict["title"]
            
            println(" value is \(value!)")
            dropDownItem.setTexts(dict["title"]!)
            
            dropdownItems.addObject(dropDownItem)
            
            
        }
        
      
     
            dropDownMenu.menuButton.text = "非常长的文本查看"
            
            dropDownMenu.dropDownItems = dropdownItems
            dropDownMenu.paddingLeft = 15
            dropDownMenu.frame = CGRectMake(60, 30, 200, 45)
            dropDownMenu.delegate = self
            
            dropDownMenu.gutterY = 5;
            dropDownMenu.type = IGLDropDownMenuType.SlidingInBoth
            
            
            dropDownMenu.reloadView()
           cardView.addSubview(dropDownMenu)
        
      
//       self..addSubview(dropDownMenu)
        //        tableView.tableFooterView = dropDownMenu
        
        //
        //
        //
        //        [self setUpParamsForDemo1];
        //
        //        [self.dropDownMenu reloadView];
        //
        //        [self.view addSubview:self.dropDownMenu];
        //        
        
        
        
        
    }

    /*
    @IBAction func addText(sender: AnyObject) {
        
//        todoListHelper.addTask(toDoListTitle.text, dateline: desc.text,complete:false)
////        SingletonClass.sharedInstance.todoList = todoListHelper.lists
//        let list = todoListHelper.lists
//
//
//        //todoListHelper.addTask(toDoListTitle.text, desc: desc.text)
//        self.view.endEditing(true)
//        toDoListTitle.text = ""
//        desc.text = ""
        
    }
    
    
    @IBAction func finishTimeAction(sender: UIButton) {
        
        var todoList: UIStoryboard!
        todoList = UIStoryboard(name: "TodoListDate", bundle: nil)
        let dataPickerVC  = todoList.instantiateViewControllerWithIdentifier("dataPicker") as UIViewController
       
       self.navigationController?.pushViewController(dataPickerVC, animated: true)
        
        
        //返回push的上一视图：
        //返回指定视图popToViewController
      //  self.navigationController?.popToRootViewControllerAnimated(true)
        
        //'Receiver (<ToDoListApp.UserAddVC: 0x7fbdd8e257c0>) has no segue with identifier 'dataPicker''
        //只适合同一个storyboard的不同ViewController在带有箭头的成为segue那里设置identifier。
       // self.performSegueWithIdentifier("dataPicker", sender: self)
       // self.presentViewController(dataPickerVC, animated: true, completion: nil)
        

        
        

        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    @IBAction func dismissVC(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)

    }
*/
 }
