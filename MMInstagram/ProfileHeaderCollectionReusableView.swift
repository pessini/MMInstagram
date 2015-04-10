//
//  ProfileHeaderCollectionReusableView.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/9/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var countPostsLabel: UILabel!
    @IBOutlet weak var countFollowersLabel: UILabel!
    @IBOutlet weak var countFollowingLabel: UILabel!
    @IBOutlet weak var nameProfileLabel: UILabel!

    override func layoutSubviews()
    {
        profilePictureImageView.layer.cornerRadius = 50.0
        profilePictureImageView.clipsToBounds = true

    }
}
