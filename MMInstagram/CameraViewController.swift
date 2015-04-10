//
//  CameraViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()



    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.image = UIImage(named: "placeholder")

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
        self.savedImageAlert()

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
        var newPost = PFObject(className:"Post")
        newPost["user"] = PFUser.query()!.getObjectWithId("4zxX3yFakw")

        newPost["message"] = "I saved an image!"

        let imageData = UIImageJPEGRepresentation(chosenImage, 0.4)
        if imageData != nil
        {
            let imageFile = PFFile(name:"chosenimage.jpg", data:imageData)
            newPost.setObject(imageFile, forKey: "photo")
            newPost["imagefile"] = imageFile
        }
        let point = PFGeoPoint(latitude:40.0, longitude:-30.0)
        newPost["photo_location"] = point


        //This saves the post to Parse

        newPost.saveInBackgroundWithBlock { (success: Bool, error) -> Void in
            if (success)
            {
                println("Photo sent sucessfully")
            }
            else
            {
                println("Photo not uploaded")
            }
        }



    }
    
    
    /**
    Alerts users that picture was saved to photo library
    */
    func savedImageAlert()
    {
        var alert:UIAlertView = UIAlertView()
        alert.title = "Saved!"
        alert.message = "Your picture was saved to Camera Roll"
        alert.delegate = self
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

}
