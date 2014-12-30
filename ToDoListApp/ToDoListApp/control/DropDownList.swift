//
//  DropDownList.swift
//  ToDoListApp
//
//  Created by desmond on 12/19/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit


@objc protocol DropDownChooseDelegate{
    optional func chooseAtSection(section:Int,index:Int)
}



@objc protocol DropDownChooseDataSource:NSObjectProtocol
{
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:Int) -> Int
    func titleInSection (section:Int,index:Int) -> String
    func defaultShowSection(section:Int) -> Int
}

class DropDownList: UITableViewController {
    
    //    required init(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var tableBaseView: UIView!
    @IBOutlet weak var mtableView: UITableView!
    
    var currentExtendSection = 0
    
    let SECTION_BTN_TAG_BEGIN  = 1000
    let SECTION_IV_TAG_BEGIN  = 3000
    
    
    var dropDownDelegate:DropDownChooseDelegate?
    var dropDownDataSource:DropDownChooseDataSource?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
      func initWithFrame(initWithFrame:CGRect,dataSource:DropDownChooseDataSource,delegate:DropDownChooseDelegate) -> AnyObject
    {
        self.view.backgroundColor = UIColor.whiteColor()
        let currentExtendSection = -1;
        self.dropDownDataSource = dataSource
        self.dropDownDelegate = delegate;
        
        var sectionNum = 0;
        
//        if let selector = self.dropDownDataSource?.respondsToSelector(Selector("numberOfSections:"))
//        {
//            if(selector)
//            {
//                if let sectionNumber = self.dropDownDataSource?.numberOfSections()
//                {
//                    sectionNum = sectionNumber
//                }
//                
//            }
//        }
//        
        if let sectionNumber = self.dropDownDataSource?.numberOfSections()
        {
            sectionNum = sectionNumber
        }

        
        if (sectionNum == 0) {
            self.view = nil;
        }
        
        //初始化默认显示view
        
        let sectionWidth = 1.f * (initWithFrame.size.width / CGFloat(sectionNum))
        
        for var i = 0 ; i<sectionNum ;i++
        {
            let sectionBtn = UIButton(frame: CGRectMake(sectionWidth * CGFloat(i), 1, sectionWidth, initWithFrame.size.height - 2))
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i
            sectionBtn.addTarget(self, action: "sectionBtnTouch:", forControlEvents: UIControlEvents.TouchUpInside)
            var sectionBtnTitle = "--"
            
            
            if let selector =  self.dropDownDataSource?.respondsToSelector(Selector("titleInSection:index:"))
            {
                if (selector)
                {
                    let index = self.dropDownDataSource?.defaultShowSection(i)
                    
                    if let title = self.dropDownDataSource?.titleInSection(i, index: index!)
                    {
                        sectionBtnTitle = title
                        sectionBtn.setTitle(sectionBtnTitle, forState: UIControlState.Normal)
                        sectionBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                        sectionBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(14.f)
                        self.view.addSubview(sectionBtn)
                    }
                    
                }
            }
            
            var x = sectionWidth * CGFloat(i) + sectionWidth - 16
            var y = (self.view.frame.size.height - 12) / 2
            
            
            var sectionImageView = UIImageView(frame: CGRectMake(x, y, 12, 12))
            sectionImageView.image = UIImage(named: "down_dark.png")
            sectionImageView.contentMode = UIViewContentMode.ScaleToFill
            sectionImageView.tag = SECTION_IV_TAG_BEGIN + i
            self.view.addSubview(sectionImageView)
            
            if(i<sectionNum && i != 0)
            {
                let lineView = UIView(frame: CGRectMake(sectionWidth * CGFloat(i), self.view.frame.size.height/4, 1, self.view.frame.size.height/2))
                lineView.backgroundColor = UIColor.lightGrayColor()
                self.view.addSubview(lineView)
            }
            
            
        }
        return self
    }
    
    
    
    func sectionBtnTouch(btn:UIButton )
    {
        var section = btn.tag - SECTION_BTN_TAG_BEGIN;
        
        var currentImageView = self.view.viewWithTag(SECTION_IV_TAG_BEGIN + currentExtendSection) as UIImageView
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            currentImageView.transform = CGAffineTransformRotate(currentImageView.transform, self.degreesToRadians(180));
            
        })
        
        
        
        if (currentExtendSection == section) {
            self.hideExtendedChooseView()
            
        }else{
            currentExtendSection = section;
            
            let currentImageView = self.view.viewWithTag(SECTION_IV_TAG_BEGIN + currentExtendSection) as UIImageView
            
            UIView.animateWithDuration(0.3, animations:
                {
                    currentImageView.transform = CGAffineTransformRotate(currentImageView.transform, self.degreesToRadians(180))
                    
            })
            
            if let index = self.dropDownDataSource?.defaultShowSection(currentExtendSection)
            {
                self.showChooseListViewInSection(currentExtendSection, index: index)
            }
            
        }
        
    }
    
    func setTitle(title:String,section:Int)
    {
        let btn = self.view.viewWithTag(SECTION_BTN_TAG_BEGIN + section) as UIButton
        btn.setTitle(title, forState: .Normal)
    }
    
    func isShow() -> Bool
    {
        if (currentExtendSection == -1) {
            return false
        }
        return true
    }
    
    func hideExtendedChooseView ()
    {
        if (currentExtendSection != -1) {
            currentExtendSection = -1
            var rect = self.mtableView.frame
            var height = rect.size.height
            height = 0
            
            UIView.animateWithDuration(0.3, animations:
                {
                    self.tableBaseView.alpha = 1.f
                    self.mtableView.alpha = 1.f
                    self.tableBaseView.alpha = 0.2.f
                    self.mtableView.alpha = 0.2
                    self.mtableView.frame = rect
                    
                }, completion: { (Bool) -> Void in
                    self.mtableView.removeFromSuperview()
                    self.tableBaseView.removeFromSuperview()
                }
            )
            
            
        }
    }
    
    
    func showChooseListViewInSection(section:Int,index:Int)
    {
        if(self.mtableView == nil)
        {
            var viewFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + self.view.frame.size.height, self.view.frame.size.width, self.superView.frame.size.height - self.view.frame.origin.y - self.view.frame.size.height)
            self.tableBaseView = UIView(frame: viewFrame)
            self.tableBaseView.backgroundColor = UIColor(white: 0.0.f, alpha: 0.5)
            
            let bgTap = UITapGestureRecognizer(target: self, action:Selector("bgTappedAction:"))
            
            self.tableBaseView.addGestureRecognizer(bgTap)
            
            var tableViewFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + self.view.frame.height, self.view.frame.size.width,240)
            
            self.mtableView = UITableView(frame: tableViewFrame, style:UITableViewStyle.Plain)
            self.mtableView.delegate = self
            self.mtableView.dataSource = self
            
            
        }
        if let sectionNumber = self.dropDownDataSource?.numberOfSections()
        {
            let  sectionWidth = self.view.frame.size.width / CGFloat(sectionNumber)
            let rect = self.mtableView.frame
            var x  = rect.origin.x
            x  = sectionWidth * CGFloat(section)
            var tableViewWidth = rect.size.width
            tableViewWidth = sectionWidth
            var tableViewHeight = rect.size.height
            tableViewHeight = 0
            self.mtableView.frame  = rect
            self.superView.addSubview(self.tableBaseView)
            self.superView.addSubview(self.mtableView)
            
            tableViewHeight = 240
            
            
            UIView.animateWithDuration(0.3, animations:
                {
                    self.tableBaseView.alpha = 0.2
                    self.mtableView.alpha = 0.2
                    self.tableBaseView.alpha = 1.0
                    self.mtableView.alpha = 1.0
                    self.mtableView.frame = rect
                }
            )
            
            self.mtableView.reloadData()
            
        }
    }
    
    
    func degreesToRadians(angle:Int) -> CGFloat
    {
        return CGFloat(angle) / CGFloat(180.0 * M_PI)
    }
    
    
    
    
    func bgTappedAction (tap:UITapGestureRecognizer)
    {
        let currentImageView = self.view.viewWithTag(SECTION_IV_TAG_BEGIN + currentExtendSection) as UIImageView
        UIView.animateWithDuration(0.3, animations:
            {
                currentImageView.transform = CGAffineTransformRotate(currentImageView.transform,self.degreesToRadians(180))
        })
        
        self.hideExtendedChooseView()
    }
    
    
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let selector =  self.dropDownDataSource?.respondsToSelector( Selector("titleInSection:index:"))
        {
            if (selector)
            {
                var chooseCellTitle = self.dropDownDataSource?.titleInSection(currentExtendSection, index: indexPath.row)
                let currentSectionBtn = self.view.viewWithTag(SECTION_BTN_TAG_BEGIN + currentExtendSection) as UIButton
                currentSectionBtn.setTitle(chooseCellTitle, forState: .Normal)
                self.dropDownDelegate?.chooseAtSection!(currentExtendSection, index: indexPath.row)
                self.hideExtendedChooseView()
                
            }
        }
        
        
        
  
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if let sectionCount = self.dropDownDataSource?.numberOfRowsInSection(currentExtendSection)
        {
            return sectionCount
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.dropDownDataSource?.titleInSection(currentExtendSection, index: indexPath.row)
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        return cell
    }
    
    
    
    
}
