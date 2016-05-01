//
//  ComposeViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 24/3/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var captionTextView: UITextView!

    @IBOutlet weak var previewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Function to post a new image
    @IBAction func addImageTapped(sender: AnyObject) {
    
        let imagePicker = UIImagePickerController()
    
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        imagePicker.allowsEditing = false
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    } // Closes addImageTapped
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.previewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //When all the information and image has been selected, to effectively post
    @IBAction func composeTapped(sender: AnyObject) {
        print(2)
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let localDate = dateFormatter.stringFromDate(date)
        
        let imageToBeUploaded = self.previewImage.image
        
        let imageData = UIImagePNGRepresentation(imageToBeUploaded!)
        
        let file: PFFile = PFFile(data: imageData!)!
        
        let fileCaption: String = self.captionTextView.text
        
        let photoToUpload = PFObject(className: "Posts")
        photoToUpload["Image"] = file
        photoToUpload["Caption"] = fileCaption
        photoToUpload["addedBy"] = PFUser.currentUser()?.username
        photoToUpload["date"] = localDate
       
        do {
            try photoToUpload.save()
            print("Successfully Posted")
            
        } catch {
            print(4)
            print (error)
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("postsController")
        self.presentViewController(vc! as UIViewController, animated:true, completion: nil)
    }//Closes composeTapped
}
