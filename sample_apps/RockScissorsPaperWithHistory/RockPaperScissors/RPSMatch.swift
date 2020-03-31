//  SingleMatch.swift
//  RockPaperScissorsWithHistory
//  Created by Jason on 11/14/14.
//  Copyright (c) 2014 Gabrielle Miller-Messner. All rights reserved.

import Foundation;

struct RPSMatch {
    // MARK: Properties
    let p1: RPS;
    let p2: RPS;
    
    // MARK: Initializer
    init(p1: RPS, p2: RPS) {
        self.p1 = p1;
        self.p2 = p2;
    }
    
    // MARK: Computed Properties
    var winner: RPS {
        get {
            return p1.defeats(p2) ? p1 : p2;
        }
    }
    
    var loser: RPS {
        get {
            return p1.defeats(p2) ? p2 : p1;
        }
    }
}
