//  TableViewController.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

/**
Class methods should be consistent with CollectionViewController
*/
class TableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    //MARK: - Properties & UI elements
    
    //MARK: - TableView contract implementations
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return 0; //placholder
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(); //placeholder
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO:
        //Instantiate ViewController
        
        //Pass/store data
        
        //Present to view controller
        // self.navigationController?.pushViewController(VC, animated: true);
    }
}
