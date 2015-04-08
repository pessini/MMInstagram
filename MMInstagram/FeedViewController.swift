//
//  FeedViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()


    }

    override func viewDidAppear(animated: Bool)
    {
        if PFUser.currentUser() == nil
        {
            self.performSegueWithIdentifier("LoginSegue", sender: nil)
        }
    }
    
    @IBAction func logOutButtonTapped(sender: UIBarButtonItem)
    {
        PFUser.logOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("InitialViewController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }


}
