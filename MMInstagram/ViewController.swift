//
//  ViewController.swift
//  MMInstagram
//
//  Created by Leandro Pessini on 4/6/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // creates an object and saves it in the Parse Backend
        let testobj: PFObject = PFObject(className: "TestObject")
        testobj["foo"] = "bar"
        testobj.saveInBackgroundWithBlock(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

