//  TableViewController.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

/**
Class methods should be consistent with CollectionViewController
*/
class TableViewController: UITableViewController {
    //MARK: - Properites & UI elements
    var memes = [Meme]();
    
    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false; //keep TabBar on by on start
    }
    
    //MARK: - TableView contract implementations
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(); //placeholder
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Instantiate ViewController:
        let sentMemeVC = self.storyboard?.instantiateViewController(identifier:Meme.ID_TABLE) as! ViewController;
        
        //Pass/store data:
        sentMemeVC.meme = Meme.getMeme(memes, indexPath);
        
        //Present to view controller:
        self.navigationController?.pushViewController(sentMemeVC, animated: true);
    }
}
