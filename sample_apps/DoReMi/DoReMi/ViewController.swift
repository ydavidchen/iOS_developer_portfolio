//
//  ViewController.swift
//  DoReMi
//
//  Created by Jason Schatz on 11/18/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit;
let LETTERS = ["C","D","E","F","G","A","B"];
let DETAILS = ["do","re","mi","fa","sol","la","ti (xi)"];

class ViewController: UIViewController, UITableViewDataSource {
    // MARK: - Properties
    // TODO Use this string property as your reuse identifier (already set in StoryBoard)
    let cellReuseIdentifier = "MyCellReuseIdentifier";
    
    // Choose some data to show in your table
    let model = Model(LETTERS, DETAILS); //TODO: custom implementation as class
    
    // MARK: - TODO: UITableViewDataSource contract methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier);
        let index = (indexPath as NSIndexPath).row;
        cell?.textLabel?.text = self.model.getId(index: index);
        cell?.detailTextLabel?.text = self.model.getDetail(index: index);
        return cell!;
    }
}
