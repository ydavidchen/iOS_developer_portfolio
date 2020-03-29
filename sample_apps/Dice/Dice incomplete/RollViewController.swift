//  RollViewController.swift
//  Dice
//  Starter code: Created by Jason Schatz on 11/6/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

/*
 3 ways for segues:
 1) Code only: instantiateViewController
 2) Code & Storyboard: setup, then performSeg method
 3) Storyboard only: touchup inside
 */

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
        // Invoke the segway
        performSegue(withIdentifier: "rollDice", sender: self); 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rollDice" {
            let controller = segue.destination as! DiceViewController;
            controller.firstValue = randomDiceValue();
            controller.secondValue = randomDiceValue();
        }
    }
    
}

