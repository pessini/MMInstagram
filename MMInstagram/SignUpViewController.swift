//
//  SignUpViewController.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    var prevUsername : String = ""
    var prevPassword : String = ""

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.usernameTextField.text = prevUsername
        self.passwordTextField.text = prevPassword

        let singleTap = UITapGestureRecognizer(target: self, action: Selector("selectPicture:"))
        singleTap.delegate = self
        view.addGestureRecognizer(singleTap)
    }

    @IBAction func onSignUpButtonTapped(sender: UIButton)
    {
        var user = PFUser()

        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        user.setValue(nameTextField.text, forKey: "name")

        let imageData = UIImagePNGRepresentation(profileImageView.image)
        if imageData != nil
        {
            let imageFile = PFFile(data: imageData)
            user.setObject(imageFile, forKey: "photo")
        }

        user.signUpInBackgroundWithBlock { (returnedResult, returnedError) -> Void in
            if returnedError == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                self.showAlert("There was an error with your sign up", error: returnedError)
            }
        }
    }

    // MARK: IBACTION

    @IBAction func selectPicture(sender: UITapGestureRecognizer)
    {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)

        if (UIImagePickerController .isSourceTypeAvailable(.PhotoLibrary))
        {
            actionSheet.addButtonWithTitle("Photo Library")
        }

        if (UIImagePickerController .isSourceTypeAvailable(.Camera))
        {
            actionSheet.addButtonWithTitle("Camera Roll")
        }

        actionSheet.addButtonWithTitle("Cancel")
        actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1
        actionSheet.showInView(self.view)
    }

    // MARK: UIImagePickerController Delegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        self.profileImageView.image = image
        self.view.layoutSubviews()
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: UIActionSheet Delegate

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex != actionSheet.cancelButtonIndex
        {
            let controller = UIImagePickerController()

            if buttonIndex != actionSheet.firstOtherButtonIndex
            {
                controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }
            else
            {
                controller.sourceType = UIImagePickerControllerSourceType.Camera
            }
            controller.delegate = self
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    // MARK: Helper Method

    func showAlert(message: String, error: NSError)
    {
        let alert = UIAlertController(title: message, message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}
