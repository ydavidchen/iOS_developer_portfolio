//  RollViewController.swift
//  Dice
//  Starter code: Created by Jason Schatz on 11/6/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import UIKit;

class RollViewController: UIViewController {
    // MARK: Methods
    /**
    * Generates a Int from 1 to 6 randomly
    */
    func randomDiceValue() -> Int {
        // Generate a random Int32 using arc4Random
        let randomValue = 1 + arc4random() % 6
        
        // Return a more convenient Int, initialized with the random value
        return Int(randomValue)
    }
    
    /**
    * Main functionality of the sample app
    */
    @IBAction func rollTheDice() {
        // Retrieve DiceViewController, be sure to manually set identifier correctly in the Identity Inspector!
        let controller: DiceViewController; //custom controller given by Udactiy
        controller = storyboard?.instantiateViewController(identifier: "DiceViewController") as! DiceViewController;
        
        // Set 2 values to random integers:
        controller.firstValue = randomDiceValue();
        controller.secondValue = randomDiceValue();
        
        present(controller, animated: true, completion: nil);
    }
    
    
}

