//
//  RegisterViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 5/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //Function that allows new users register, the data gets stored and visible on Parse Dashboard
    @IBAction func registerTapped(sender: AnyObject) {
        
        //Fields of the sign up form
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        //Error handling
        user.signUpInBackgroundWithBlock({
            (succeeded: Bool, error: NSError?) -> Void in
            
            if error == nil {
                
                //When succeeding in signing up
                print("Successfully signed up")
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("logInVC")
                self.presentViewController(vc! as UIViewController, animated:true, completion:nil)
            
            } else {
               
                //When failing in signing up
               let alertController = UIAlertController(title: "Error", message: "There was one or more errors in the registration", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            
            }
        })
    }// Closes registerTapped()
}
