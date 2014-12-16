//
//  ExtensionTableViewTableViewController.swift
//  ToDoListApp
//
//  Created by desmond on 12/12/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit


enum WaveAnimation: Int {
    
    case LeftToRightWaveAnimation = -1
    case RightToLeftWaveAnimation = 1
    
}

extension UITableView
{
    func reloadDataAnimateWithWave(animation:WaveAnimation)
    {
        
        self.setContentOffset(self.contentOffset, animated: false)
        //连续点击问题修复：cell复位已经确保之前动画被取消
        self.classForCoder.cancelPreviousPerformRequestsWithTarget(self)
        
        UIView.transitionWithView(self, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.hidden = true
            self.reloadData()
            }) { (finished) -> Void in
                self.visibleRowsBeginAnimation(animation)
                self.hidden = false
        }
        
    }
    
    func visibleRowsBeginAnimation(animation:WaveAnimation)
    {
        let array = self.indexPathsForVisibleRows()
        
        if let visibleRows = array
        {
            let count = visibleRows.count
            for var i = 0; i < count;i++
            {
                
                let path = visibleRows[i] as NSIndexPath
                let cell = self.cellForRowAtIndexPath(path)
                cell?.frame =   self.rectForRowAtIndexPath(path)
                cell?.hidden = true
                cell?.layer.removeAllAnimations()
                let pathArray = [path,NSNumber(integer: animation.rawValue)]
                
                println("pathArray \(pathArray)")
                
                //  [self performSelector:@selector(animationStart:) withObject:array afterDelay:.08*i];
                
                self.swift_performSelector(Selector("animationStart:"), withObject: pathArray, afterDelay: 0.1 * Double(i))

                
                
                
            }
            
        }
    }
    
    
   
    
    func animationStart(array:[AnyObject]!)
    {
        let path  = array[0] as NSIndexPath
        let i =  array[1].floatValue as NSNumber
        if let cell = self.cellForRowAtIndexPath(path)
        {
            let originPoint = cell.center
            
            let number = cell.frame.size.width
            
            let cellWidth = cell.frame.size.width
            let beginPoint = CGPointMake(cellWidth * CGFloat(3), originPoint.y)
            let bounceDistance = 2.f
            
            let endBounce1Point = CGPointMake(originPoint.x - CGFloat(i)*2*bounceDistance, originPoint.y)
            let endBounce2Point = CGPointMake(originPoint.x + CGFloat(i)*2*bounceDistance, originPoint.y)
            
            
            cell.hidden = false
            
            let move = CAKeyframeAnimation(keyPath: "position")
            move.keyTimes = [NSNumber(float: 0.0),NSNumber(float: 0.8),NSNumber(float: 0.9),NSNumber(float: 1.0)]
            move.values = [NSValue(CGPoint: beginPoint),NSValue(CGPoint: endBounce1Point),NSValue(CGPoint: endBounce2Point),NSValue(CGPoint: originPoint)]
            move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);

            let opaAnimation = CABasicAnimation(keyPath: "opacity")
            opaAnimation.fromValue = 0.f
            opaAnimation.toValue = 1.f
            opaAnimation.autoreverses = false
            
            let group = CAAnimationGroup()
            
            group.animations = [move,opaAnimation]
            group.duration = 1
            group.removedOnCompletion = false
            group.fillMode = kCAFillModeBackwards
            
            cell.layer.addAnimation(group, forKey:nil)
        }
    }

}