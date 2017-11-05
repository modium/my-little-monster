//
//  DragImg.swift
//  mylittlemonster
//
//  Created by Jaf Crisologo on 2016-03-29.
//  Copyright © 2016 Modium Design. All rights reserved.
//

import Foundation
//needed to subclass UIImageView
import UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint!
//    var dropTarget: UIImageView!
    var dropTarget: UIView? //*This is an optional because...what if the user doesn't want to feed the monster?
    
    //override the required initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //the touches parameter is passing off a collection of touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("I just touched the screen")
        originalPosition = self.center //get the image view's center
    }
  
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            //grab the position of the image view within the entire view
            let position = touch.location(in: self.superview)
            //move the image view to the new position
            self.center = CGPoint.init(x: position.x, y: position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //check if you've dropped it on top of your target
        //the comma is akin to &&
        if let touch = touches.first, let target = dropTarget {
            
            let position = touch.location(in: self.superview)
            
            //if dragged image is on top of the target image, create a notification called 'onTargetDropped' that the ViewController will listen for
            if target.frame.contains(position){
                NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "onTargetDropped"), object: nil) as Notification)
            }
        }
        
        self.center = originalPosition
    }
    
}
