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

    // MARK: queryForUserFeed

    func queryForUserFeed()
    {
        let queryUsersToShow = PFQuery(className: "Follow")
        queryUsersToShow.whereKey("from", equalTo: PFUser.currentUser()!)

        let query =  PFQuery(className: "Post")
        query.whereKey("user", matchesKey: "to", inQuery: queryUsersToShow)

        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (returnedObject, returnedError) -> Void in
            if returnedError == nil
            {
                self.feedArray = returnedObject as! [PFObject]
                self.feedTableView.reloadData()
            }
            else
            {
                self.showAlert("There was an issue with getting your objects", error: returnedError!)
            }
        }
    }

    // MARK: TableViewDataSource Delegate

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedArray.count;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 300.0;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as! PostTableViewCell
        let post = feedArray[indexPath.row] as PFObject

        let userImageFile = post["photo"] as! PFFile

        userImageFile.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if error == nil {
                let image = UIImage(data:imageData!)
                cell.postImageView.image = image
            }
        }

        cell.postMessage.text = post["message"] as? String

        // button like pressed
//        cell.likeButton = LikeButton() as UIButton
//
//        cell.likeButton.exclusiveTouch = false
        cell.likeButton.tag = indexPath.row

        cell.likeButton.addTarget(self, action: "likePost:", forControlEvents: UIControlEvents.TouchUpInside)



        // button comment pressed

        cell.commentButton.tag = indexPath.row
        cell.commentButton.addTarget(self, action: "commentsPost:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }

    func likePost(button: UIButton, likeId: String?)
    {
        button.selected = !button.selected

        if button.selected
        {
            var like = PFObject(className: "Like")
            like["user"] = PFUser.currentUser()
            like["post"] = feedArray[button.tag] as PFObject
            like.saveInBackgroundWithBlock({ (saved, error) -> Void in
                if saved
                {
                    println("Salvou")
                }
                else
                {
                    println("Não")
                }
            })
        }
        else
        {

//            var unlike = PFObject(withoutDataWithClassName: "Like", objectId: like.objectId)
//
//            println(unlike)
//            var unlike = PFObject(withoutDataWithObjectId: post.objectId)
//
//            unlike.deleteInBackgroundWithBlock({ (deleted, error) -> Void in
//                if deleted
//                {
//                    println("DELETOU")
//                }
//                else
//                {
//                    println("NAO DELETOU")
//                }
//            })

        }
    }

    func commentsPost(button: UIButton)
    {

        self.performSegueWithIdentifier("ShowComments", sender: button)
    }

    @IBAction func logOutButtonTapped(sender: UIBarButtonItem)
    {
        PFUser.logOut()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("InitialViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowComments"
        {
            let vc = segue.destinationViewController as! CommentViewController
            let post = feedArray[sender!.tag] as PFObject
            vc.post = post
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
