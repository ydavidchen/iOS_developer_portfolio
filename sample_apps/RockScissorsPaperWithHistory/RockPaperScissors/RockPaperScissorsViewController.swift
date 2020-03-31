//  RockPaperScissorsViewController.swift
//  RockPaperScissorsWithHistory
//  Created by Gabrielle Miller-Messner on 10/30/14.
//  Copyright (c) 2014 Gabrielle Miller-Messner. All rights reserved.

import UIKit;

class RockPaperScissorsViewController: UIViewController {
    // MARK: - Properties
    var match: RPSMatch!;
    var history = [RPSMatch](); //holds reuslts of ea play
    
    // MARK: - Outlets
    @IBOutlet weak var rockButton: UIButton!;
    @IBOutlet weak var paperButton: UIButton!;
    @IBOutlet weak var scissorsButton: UIButton!;
    
    // MARK: - UI actions
    @IBAction func makeYourMove(_ sender: UIButton) {
        switch (sender) {
        case self.rockButton:
            throwDown(RPS.rock);
        case self.paperButton:
            throwDown(RPS.paper);
        case self.scissorsButton:
            throwDown(RPS.scissors);
            
        default:
            assert(false, "An unknown button is invoking makeYourMove()");
        }
    }
    
    @IBAction func showHistory(_ sender: AnyObject) {
        //TODO: Present HistoryViewController -- note syntax, iOS>13.1 required
        let storyboard = self.storyboard;
        let controller = storyboard?.instantiateViewController(identifier: "HistoryViewController")as! HistoryViewController;
        controller.history = self.history;
        present(controller, animated: true, completion: nil);
    }
    
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Notice that this code works for both Scissors and Paper
        let controller = segue.destination as! ResultViewController;
        controller.match = self.match;
    }
    
    // MARK: - Custom methods for RPS game
    func throwDown(_ playersMove: RPS) {
        //Generates opponent's move
        let computersMove = RPS();
        
        //Store the results of a match
        self.match = RPSMatch(p1: playersMove, p2: computersMove);
        history.append(match);
        
        /**
        TODO: 3 ways of presenting a ViewController
        */
        //1st Way: Programmatic View Controller Presentation
        if (playersMove == RPS.rock) {
            // Get the Storyboard & ResultViewController
            let storyboard = UIStoryboard (name: "Main", bundle: nil);
            let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController;
        
            // Communicate the match
            resultVC.match = self.match;
            self.present(resultVC, animated: true, completion: nil);
        }
        
        // 2nd Way: Code + Segue
        else if (playersMove == RPS.paper) {
            performSegue(withIdentifier: "throwDownPaper", sender: self);
        }
        
        // TODO: 3rd Way: Segue w/ prepareForSegue only
        
    }
}
