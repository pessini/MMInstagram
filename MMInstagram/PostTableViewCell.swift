//
//  PostTableViewCell.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/8/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {


    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postMessage: UILabel!




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
