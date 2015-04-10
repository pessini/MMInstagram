//
//  CameraViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet var onVideoButtonPressed: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var OverlayView: UIView!
    let imagePicker = UIImagePickerController()


    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker.delegate = self
        imageView.image = UIImage(named: "placeholder")

        // create fictitious posts


//            Class - Post
//            - User who is posting
//            - message
//            - Photo itself
//            - Location (GeoPoint)

//        var newPost = PFObject(className:"Post")
//        newPost["user"] = PFUser.query()!.getObjectWithId("4zxX3yFakw")
//        //4zxX3yFakw - facebook
//        //yLsKDKrKpE - matt
//        // FJxitV80U1 - pessini
//        newPost["message"] = "WOW lol"
//
//        let imageData = UIImageJPEGRepresentation(UIImage(named: "image6"), 1.0)
//        if imageData != nil
//        {
//            let imageFile = PFFile(data: imageData)
//            newPost.setObject(imageFile, forKey: "photo")
//        }
//        let point = PFGeoPoint(latitude:40.0, longitude:-30.0)
//        newPost["photo_location"] = point
//        
//        // This will save a newPost
//
//        newPost.saveInBackgroundWithBlock { (success: Bool, error) -> Void in
//            if (success)
//            {
//                println("YEAH babe")
//            }
//            else
//            {
//                println("UGHR ERROR")
//            }
//        }


    }


    /**
    Allows user to connect to photo library

    :param: sender button
    */

    @IBAction func photoLibrary(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false;
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    /**
    Controls Camera and Photo Functions

    :param: imagePicker imagePicker
    :param: info        controls photo functionality
    */
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject] )
    {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFit
        imageView.image = chosenImage

        postToDB(chosenImage!)
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil)

        dismissViewControllerAnimated(true, completion: nil)
    }


    /**
    Cancel Photo Library

    :param: picker imagePicker
    */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /**
    Calls the camera function to take picture

    :param: sender UIImagePicker
    */
    @IBAction func takePhoto(sender: AnyObject) {

        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            var picker = UIImagePickerController()
            imagePicker.sourceType = .Camera
            imagePicker.showsCameraControls = true

            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera Detected.")
        }
    }


    // Post picture to DB
    func postToDB(chosenImage: UIImage)
    {

        //Parse Code
        var newPost = PFObject(className:"Post")
        newPost["user"] = PFUser.currentUser()

        newPost["message"] = "All your base belongs to us"

        let imageData = UIImageJPEGRepresentation(chosenImage, 1.0)
        if imageData != nil
        {
            let imageFile = PFFile(name:"image.jpg", data:imageData)
            newPost.setObject(imageFile, forKey: "photo")
            newPost["imagefile"] = imageFile
        }
        let point = PFGeoPoint(latitude:40.0, longitude:-30.0)
        newPost["photo_location"] = point

        // This will save a newPost

        newPost.saveInBackgroundWithBlock { (success: Bool, error) -> Void in
            if (success)
            {
                self.savedShowFeed()
            }
            else
            {
                println("UGHR ERROR")
            }
        }



    }


    /**
    Alerts users that picture was saved to photo library
    */
    func savedShowFeed()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("InitialViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }




    //    @IBAction func onVideoButtonPressed(sender: UIBarButtonItem) {
    //
    //        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
    //        {
    //            var picker = UIImagePickerController()
    //            imagePicker.mediaTypes = [kUTTypeMovie!]
    //            imagePicker.allowsEditing = true
    //            imagePicker.delegate = self
    //            imagePicker.videoMaximumDuration = NSTimeInterval (15)
    //            imagePicker.videoQuality = UIImagePickerControllerQualityType.Type640x480
    //            presentViewController(imagePicker, animated: true, completion: nil)
    //        }
    //        else{
    //            NSLog("No Video Camera Detected.")
    //        }
    //        }
    //

}
