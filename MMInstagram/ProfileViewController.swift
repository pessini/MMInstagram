//
//  ProfileViewController.swift
//  MMInstagram
//
//  Created by Matt Larkin on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var profileColletionView: UICollectionView!
    var photosArray: [PFObject] = []
//    var userProfileData: PFObject?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        profileColletionView.dataSource = self
        profileColletionView.delegate = self

        navigationController?.navigationItem.title = PFUser.currentUser()?.username
    }

    override func viewDidAppear(animated: Bool)
    {
        queryForGetPhotos()
    }

    // MARK: Query

    func queryForGetPhotos()
    {
        let query = PFQuery(className: "Post")
//        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (returnedObject, returnedError) -> Void in
            if returnedError == nil
            {
                self.photosArray = returnedObject as! [PFObject]
                self.profileColletionView.reloadData()
            }
            else
            {
                self.showAlert("There was an issue with getting your objects", error: returnedError!)
            }
        }
    }

    // MARK: UIColletionViewDataSource Delegate

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photosArray.count;
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {

        var reusableView: UICollectionReusableView?

        if kind == UICollectionElementKindSectionHeader
        {
            let headerView = profileColletionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView

            var query = PFUser.query()
            let user = query!.getFirstObject() as PFObject!
            let userImageFile = user["photo"] as! PFFile

            userImageFile.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                if error == nil {
                    let image = UIImage(data:imageData!)
                    headerView.profilePictureImageView.image = image
                }
            }

            headerView.nameProfileLabel.text = user["name"] as? String

            reusableView = headerView
        }

        return reusableView!

    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        // go to photo
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell

        let post = photosArray[indexPath.row] as PFObject
        let photoFile = post["photo"] as! PFFile
        photoFile.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if error == nil {
                let image = UIImage(data:imageData!)
                cell.photoImageView.image = image
            }
        }
        return cell
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
