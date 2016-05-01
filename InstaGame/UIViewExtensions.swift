//
//  UIViewExtensions.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 9/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func fadeIn() {
        func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
            UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.alpha = 1.0
                }, completion: completion)  }
    }
    func fadeOut(){
        func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
            UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.alpha = 0.0
                }, completion: completion)
        }
    }
}