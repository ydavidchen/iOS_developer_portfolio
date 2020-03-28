//  Sample App in preparation for the MemeMe Project
//  ViewController.swift
//  ClickCounter
//
//  Created by DavidKevinChen on 3/27/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

/* Notes
Start without manually handle Storyboard
View is set automatically by Xcode
 */

import UIKit;

class ViewController: UIViewController {
    //MARK: Properties
    var count = 0;
    @IBOutlet var label: UILabel!;
    
    //MARK: - Customize onstart methods
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    /* MARK: - Methods */
    @IBAction func incrementCount() {
        self.count += 1;
        displayCurrCount();
        toggleBackCol();
    }
    
    /* MARK: - Helper functions */
    @objc func displayCurrCount() {
        self.label.text = "\(self.count)";
    }
    
    @IBAction func toggleBackCol(color:UIColor=UIColor.gray) {
        if self.view.backgroundColor == color {
            self.view.backgroundColor = UIColor.white;
        } else {
            self.view.backgroundColor = color;
        }
    }
}

