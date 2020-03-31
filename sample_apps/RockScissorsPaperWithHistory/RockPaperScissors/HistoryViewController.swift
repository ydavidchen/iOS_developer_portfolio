//  HistoryViewController.swift
//  RockPaperScissorsWithHIstory
//  Created by DavidKevinChen on 3/30/20.
//  Copyright © 2020 Gabrielle Miller-Messner. All rights reserved.

import UIKit;
let PROTO_CELL_ID = "HistoryCell";

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: -Properties
    var history: [RPSMatch]!;
    
    //MARK: - UITableViewDataSource & Delegate contract methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return history.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let cell = tableView.dequeueReusableCell(withIdentifier:PROTO_CELL_ID);
        
        let match = self.history[(indexPath as NSIndexPath).row];
        cell?.textLabel?.text = getWinningInfo(match);
        cell?.detailTextLabel?.text = "\(match.p1) vs. \(match.p2)";
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func getWinningInfo(_ match: RPSMatch) -> String {
        if(match.p1 == match.p2) {
            return "Tie";
        }
        if(match.p1.defeats(match.p2)){
            return "Win";
        }
        return "Lost";
    }
}
