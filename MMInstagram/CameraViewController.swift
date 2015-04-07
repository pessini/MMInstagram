//
//  CameraViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var images : [UIImage] = []
    var controller : UIImagePickerController?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func takePhotoAction(sender: AnyObject) {
        if isCameraAvailable() {
            let imagePickerController: UIImagePickerController = UIImagePickerController()

            imagePickerController.sourceType = .Camera
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self

            presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            println("Camera is not available")
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        var currentImage: UIImage!
        currentImage = info[UIImagePickerControllerEditedImage] as UIImage

        images.append(currentImage)
        println("Image stored in array")
        println("Number of stored images: \(images.count)")

        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }


}
