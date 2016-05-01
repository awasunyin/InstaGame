//
//  TabBarViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 22/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit

extension UIImage {
    
    //Eliminates the selecting box of the tab item
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor(red: 0.9098, green: 0.1176, blue: 0.149, alpha: 1.0) /* #e81e26 */
        
        // Uses the original colors for your images, so they aren't not rendered as grey automatically.
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
            
        //TO DO: Fix the but that makes the Chat Icon disappear when selected
            
        }
    }
}
