//
//  FeedViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/7/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feedTableView: UITableView!

    var feedArray: [PFObject] = []
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Table View Delegate
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self




    }

    // MARK: Query

    func queryForUserFeed()
    {
        let queryUsersToShow = PFQuery(className: "Follow")
        queryUsersToShow.whereKey("from", equalTo: PFUser.currentUser())

        let query =  PFQuery(className: "Post")
        query.whereKey("user", matchesKey: "to", inQuery: queryUsersToShow)
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (returnedObject, returnedError) -> Void in
            if returnedError == nil
            {
                self.feedArray = returnedObject as [PFObject]
                self.feedTableView.reloadData()
            }
            else
            {
                self.showAlert("There was an issue with getting your objects", error: returnedError)
            }
        }
    }

    // MARK: TableViewDataSource Delegate

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedArray.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as PostTableViewCell
        let post = feedArray[indexPath.row] as PFObject

//        let userImageFile = post["imageFile"] as PFFile
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData!, error: NSError!) -> Void in
//            if error == nil {
//                let image = UIImage(data:imageData)
//            }
//        }
//        cell.postImageView.image = post["phot"] as? UIImage

        cell.postMessage.text = post["message"] as? String
        return cell
    }

    override func viewWillAppear(animated: Bool)
    {
        if PFUser.currentUser() == nil
        {
            self.performSegueWithIdentifier("LoginSegue", sender: nil)
        }
        else
        {
            queryForUserFeed()
        }
    }

    @IBAction func logOutButtonTapped(sender: UIBarButtonItem)
    {
        PFUser.logOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("InitialViewController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
