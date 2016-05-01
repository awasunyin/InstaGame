//
//  SettingsViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 7/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Function to log out and return to the log in view
    @IBAction func logOutTapped(sender: AnyObject) {
        
        PFUser.logOut()
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("logInVC")
        self.presentViewController(vc!, animated: true, completion: nil)
    }//Closes logOutTapped
}
