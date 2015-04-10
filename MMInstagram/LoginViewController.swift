//
//  LoginViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fbLoginView: FBLoginView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]

//        if !PFFacebookUtils.isLinkedWithUser(PFUser.currentUser())
//        {
//            PFFacebookUtils.linkUser(PFUser.currentUser(), permissions:nil,
//                {
//                (succeeded: Bool!, error: NSError!) -> Void in
//                if succeeded != nil
//                {
//                    println("Woohoo, user logged in with Facebook!")
//                }
//            })
//        }

    }

    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser() != nil
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func onLogInButtonTapped(sender: UIButton)
    {

        PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text) { (returnedUser, returnedError) -> Void in

            if returnedError == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                self.showAlert("There was an error with your login", error: returnedError!)
            }
        }
    }

    // MARK: Facebook Delegate Methods

    func loginViewShowingLoggedInUser(loginView : FBLoginView!)
    {
        println("User Logged In")
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser)
    {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as! String
        println("User Email: \(userEmail)")

        PFFacebookUtils.logInWithPermissions(fbLoginView.readPermissions, block: { (user, error) -> Void in
            if let user = user
            {
                if user.isNew
                {
                    println("User signed up and logged in through Facebook!")

                }
                else
                {
                    println("User logged in through Facebook!")
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                println("Uh oh. The user cancelled the Facebook login.")
            }

        })
    }

    func loginViewShowingLoggedOutUser(loginView : FBLoginView!)
    {
        println("User Logged Out")
    }

    func loginView(loginView : FBLoginView!, handleError:NSError)
    {
        println("Error: \(handleError.localizedDescription)")
    }

    // MARK: Helper Method

    func showAlert(message: String, error: NSError)
    {
        let alert = UIAlertController(title: message, message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowSignUpSegue"
        {
            let vc = segue.destinationViewController as! SignUpViewController
            vc.prevUsername = self.usernameTextField.text
            vc.prevPassword = self.passwordTextField.text
        }
    }



}
