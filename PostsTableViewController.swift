//
//  PostsTableViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 24/3/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class PostsTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    //TO DO: Fix the lack of spacing between the navigation bar and the top border
    
    var images = [PFFile]()
    var imageCaptions = [String]()
    var imageDates = [String]()
    var imageUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gonna call a function when refreshing
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PostsTableViewController.refreshPulled), forControlEvents: UIControlEvents.ValueChanged)
        
        let userQuery = PFUser.query()
        userQuery?.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        userQuery?.findObjectsInBackgroundWithBlock({
            (objects: [PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    let followingWho = object["followingWho"] as! NSArray
                    self.loadData(followingWho)
                }
                
            } else {
                
                NSLog("Error")
            }
        })
        
        self.tableView.reloadData()

        }
    
    func refreshPulled(){
        
        let userQuery = PFUser.query()
        userQuery?.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        userQuery?.findObjectsInBackgroundWithBlock({
            (objects: [PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    let followingWho = object["followingWho"] as! NSArray
                    self.loadData(followingWho)
                }
                
            } else {
                
                NSLog("Error")
            }
        })
        
        self.tableView.reloadData()
        
        refreshControl?.endRefreshing()
    } //Closes refreshPulled
    
    //Query to load all the data, query to find objects in the selected class on Parse
    func loadData(followingWho: NSArray){
        
        let query = PFQuery(className: "Posts")
        query.whereKey("addedBy", containedIn: followingWho as [AnyObject])
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (posts: [PFObject]?, error: NSError?) -> Void in
            
            if (error == nil) {
            
                //Succesful
                for post in posts! {
                    self.images.append(post["Image"]as! PFFile)
                    self.imageCaptions.append(post["Caption"] as! String)
                    self.imageDates.append(post["date"] as! String)
                    self.imageUsers.append(post["addedBy"] as! String)
                }
                    
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
    } //Closes loadData()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows equals number of images
        return images.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell
        
        // Configure the cell: PostCell
    
        let imageToLoad = self.images[indexPath.row] as PFFile
        let imageCaption = self.imageCaptions[indexPath.row] as String
        let imageDate = self.imageDates[indexPath.row] as String
        let imageUser = self.imageUsers[indexPath.row] as String
        var imageData: NSData = NSData()

        do {
        
            imageData = try imageToLoad.getData()
        } catch {
            print(error)
        }
        
        let finalizedImage = UIImage(data: imageData)
        
        cell.postImageView.image = finalizedImage
        cell.postCaption.text = imageCaption
        cell.addedBy.text = imageUser
        cell.dateLabel.text = imageDate
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
