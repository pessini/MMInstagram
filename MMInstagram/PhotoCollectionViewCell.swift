//
//  PhotoCollectionViewCell.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/9/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!

    override func layoutSubviews()
    {
        super.layoutSubviews()
//        photoImageView.frame = self.contentView.bounds;

        let widthCell: CGFloat = 100.0
        let heightCell: CGFloat = 100.0

        let newWidth: CGFloat = UIScreen.mainScreen().bounds.size.width / 2
        let newHeight: CGFloat = (heightCell * newWidth) / widthCell

        photoImageView.frame.size = CGSizeMake(newWidth, newHeight)

        photoImageView.backgroundColor = UIColor.grayColor()
    }

    override func layoutIfNeeded()
    {

    }
}
