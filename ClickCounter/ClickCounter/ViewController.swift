//  Sample App in preparation for MemeMe Project
//  ViewController.swift
//  ClickCounter
//
//  Created by DavidKevinChen on 3/27/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

// Do this project without manually handle Storyboard

import UIKit

// Note that the View is set automatically by Xcode
class ViewController: UIViewController {
    //MARK: Properties
    var count = 0;
    var label: UILabel!; //optional/conditional type required on init.
    var mirror: UILabel!;
    
    //MARK: Recall runs onStart
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Example Storyboard-less maneuver: Label
        let label = UILabel();
        label.frame = CGRect(x:150, y:150, width:60, height: 60);
        label.text = "0"; //init value
        view.addSubview(label);
        self.label = label;
        
        // Example 2: Button with incrementCount() as target action
        let button = UIButton();
        button.frame = CGRect(x:150, y:250, width:100, height: 100);
        button.setTitle("Click: +1", for: .normal);
        button.setTitleColor(UIColor.blue, for: .normal);
        view.addSubview(button);
        
        button.addTarget(self, action: #selector(ViewController.incrementCount), for:UIControl.Event.touchUpInside);
        
        // Homework: Another label that mirrors
        let mirror = UILabel();
        mirror.frame = CGRect(x:200, y:150, width:60, height: 60);
        mirror.text = label.text;
        view.addSubview(mirror);
        self.mirror = mirror;
        
        // Homework: Add decrement button
        let decButton = UIButton();
        decButton.frame = CGRect(x:150, y:300, width:100, height:100);
        decButton.setTitle("Click: -1", for:.normal);
        decButton.setTitleColor(UIColor.red, for:.normal);
        view.addSubview(decButton);
        
        decButton.addTarget(self, action:#selector(ViewController.decrementCount), for:UIControl.Event.touchUpInside);
    }
    
    /* MARK: Methods */
    @objc func incrementCount() {
        self.count += 1;
        displayCurrCount();
        toggleBackCol();
    }
    
    @objc func decrementCount() {
        self.count -= 1;
        displayCurrCount();
        toggleBackCol();
    }
    
    /* MARK: Helper functions */
    @objc func displayCurrCount() {
        self.label.text = "\(self.count)";
        self.mirror.text = self.label.text;
    }
    
    @objc func toggleBackCol(color:UIColor=UIColor.gray) {
        if self.view.backgroundColor == color {
            self.view.backgroundColor = UIColor.white;
        } else {
            self.view.backgroundColor = color;
        }
    }
}

