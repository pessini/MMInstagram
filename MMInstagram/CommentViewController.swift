//
//  CommentViewController.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/9/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var commentTableView: UITableView!
    var post : PFObject!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        println("comment")

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = commentTableView.dequeueReusableCellWithIdentifier("CommentCell") as! UITableViewCell

        return cell
        
    }

}
