//
//  ViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 24/3/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logInTapped(sender: AnyObject) {
        
        let username = usernameField.text
        let password = passwordField.text
        
        //Checks on Parse
        PFUser.logInWithUsernameInBackground(username!, password: password!) {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if(error == nil) {
                
            //Successfully Logged In
                currentSessionUN = username!
                currentSessionPW = password!
                print ("Successfully logged in")
               
                //Show Posts view
                let vc: AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("postsController")
                self.presentViewController(vc as! UIViewController, animated: true, completion: nil)
            
            } else {
                
            //Failed logging in
                let alertController = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }// Closes logInTapped()
}

