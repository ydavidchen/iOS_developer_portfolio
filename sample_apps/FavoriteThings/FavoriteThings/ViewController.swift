//  ViewController.swift
//  FavoriteThings
//  Created by Jason Schatz on 11/18/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import UIKit;

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    // MARK: - Model
    let favoriteThings = ["Raindrops", "Whiskers", "Kettles", "Mittens"];
    let CELL_IDENTIFIER = "FavouriteThingCell";
    
    
    // MARK: - TableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Gets number of rows in table
        let rowCount = self.favoriteThings.count;
        return rowCount;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER);
        cell?.textLabel?.text = self.favoriteThings[(indexPath as NSIndexPath).row];
        return cell!;
    }
}
