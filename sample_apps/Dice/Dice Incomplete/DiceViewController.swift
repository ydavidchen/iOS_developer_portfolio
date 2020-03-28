//  DiceViewController.swift
//  Dice
//
//  Created by Jason Schatz on 11/6/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import Foundation;
import UIKit;

class DiceViewController: UIViewController {
    // MARK: Properties
    var firstValue: Int? //wrapped conditional
    var secondValue: Int?
    
    // MARK: Outlets
    @IBOutlet var firstDie: UIImageView!
    @IBOutlet var secondDie: UIImageView!
    
    // MARK: Activity Lifecycle Methods/Callbacks
    override func viewWillAppear(_ animated: Bool) {
        // Dice only appear if firstValue and secondValue were set
        if let firstValue = self.firstValue { //if let conditionally unwraps
            self.firstDie.image = UIImage(named: "d\(firstValue)");
        } else {
            self.firstDie.image = nil;
        }
        
        if let secondValue = self.secondValue {
            self.secondDie.image = UIImage(named: "d\(secondValue)");
        } else {
            self.secondDie.image = nil;
        }
        
        self.firstDie.alpha = 0;
        self.secondDie.alpha = 0;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.firstDie.alpha = 1;
            self.secondDie.alpha = 1;
        }
    }
    
    // MARK: Custom Actions/Methods
    /**
    * Accepts a conditional Int, and returns an dice image, or nil
    */
    func imageForValue(_ value: Int?) -> UIImage? {
        return nil
    }
    
    /**
    *    Dismisses this view controller
    */
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
