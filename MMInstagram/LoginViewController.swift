//
//  LoginViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

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
                self.showAlert("There was an error with your login", error: returnedError)
            }
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowSignUpSegue"
        {
            let vc = segue.destinationViewController as SignUpViewController
            vc.prevUsername = self.usernameTextField.text
            vc.prevPassword = self.passwordTextField.text
        }
    }


}
