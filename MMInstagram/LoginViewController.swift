//
//  LoginViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var logInView: UIView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.logInView.hidden = false
        self.signUpView.hidden = true

    }

    
    @IBAction func onLoginButtonTapped(sender: UIButton)
    {
        self.logInView.hidden = false
        self.signUpView.hidden = true
    }

    @IBAction func onSignUpButtonTapped(sender: UIButton)
    {
        self.logInView.hidden = true
        self.signUpView.hidden = false
    }

}
