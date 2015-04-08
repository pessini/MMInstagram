//
//  CameraViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController{


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // create fictitious posts

        /*
            We have two classes on Parse to store from a post
        
            Class 1 - Post
            - User who is posting
            - message
        
            Class 2 - Photo
            - Post which belongs it
            - Photo itself
            - Location (GeoPoint)




        var newPost = PFObject(className:"Post")
        newPost["user"] = PFUser.query().getObjectWithId("yLsKDKrKpE")
        newPost["message"] = "Just another photo, ok?"

        var newPhoto = PFObject(className: "Photo")
        newPhoto["post"] = newPost // // Add a relation between the Post and Photo
        // I'm getting an image from my Assets folder but you have to get the image saved
        // quite simples like (self.postImageView.image)
        let imageData = UIImageJPEGRepresentation(UIImage(named: "matt2"), 1.0)
        if imageData != nil
        {
            let imageFile = PFFile(data: imageData)
            newPhoto.setObject(imageFile, forKey: "photo")
        }
        let point = PFGeoPoint(latitude:40.0, longitude:-30.0)
        newPhoto["location"] = point
        
        // This will save both newPost and newPhoto or it should :)
        newPhoto.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success)
            {
               println("YEAH babe")
            }
            else
            {
               println("UGHR ERROR")
            }
        }
*/

    }

}
