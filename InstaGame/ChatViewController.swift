//
//  ChatViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 18/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse

var currentSessionUN = ""
var currentSessionPW = ""

class ChatViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var chatWith: UITextField!
    
    
    var chattingWith = false
    
    //Updates every second
    var updateTimer = NSTimer()
    let updateDelay = 1.0
    
    var currentData: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateDelay, target: self, selector: #selector(ChatViewController.update), userInfo: nil, repeats: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //Limited to 1000 texts
    func update() {
        let query = PFQuery(className: "Chat")
        query.limit = 1000
        let objects = try! query.findObjects()
        currentData = []
        
        //Fetches data in Parse "Chat class"
        for i in objects {
            
            var finalDictionary: [String: String] = [:]
            finalDictionary["username"] = i.objectForKey("username")! as? String
            finalDictionary["text"] = i.objectForKey("text")! as? String
            
            if chattingWith {
                
                if i.objectForKey("username")! as! String == chatWith.text! && i.objectForKey("to")! as! String == currentSessionUN || i.objectForKey("username")! as! String == currentSessionUN && i.objectForKey("to")! as! String == chatWith.text! {
                    currentData.append(finalDictionary)
                }
                
            } else {
                
                if i.objectForKey("to")! as! String == "" {
                    currentData.append(finalDictionary)
                }
            }
        }
        
        tableView.reloadData()
    }// Closes update()
    
    //Number of rows equals to number of strings
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    //Customised cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customChatCell") as! ChatCell
        cell.chatText.text = currentData[indexPath.row]["text"]!
        cell.chatUser.text = currentData[indexPath.row]["username"]!
        return cell
    }
    
    //Selecting receiver of texts
    @IBAction func initiatePrivateChat(sender: AnyObject) {
        chattingWith = !chattingWith
        chatWith.text = chattingWith ? chatWith.text! : ""
    }
    
    //Sending texts
    @IBAction func send(sender: AnyObject) {
        let obj = PFObject(className: "Chat")
        obj.setObject(currentSessionUN, forKey: "username")
        obj.setObject(message.text!, forKey: "text")
        obj.setObject(chattingWith ? chatWith.text! : "", forKey: "to")
        try! obj.save()
        message.text = ""
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}