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
    var memes = Constants.getMemesFromAppDele();
    
    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false; //keep TabBar on by on start
    }
    
    //MARK: - Custom methods:
    @IBAction func addMeme(_ sender: Any) {
        Constants.triggerSentMemeVC(self.storyboard!, self.navigationController!);
    }
    
    //MARK: - TableView contract implementations
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = Constants.getMeme(memes, indexPath);
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.ID_TABLEVIEW) as! TableViewCell;
        cell.memeImageView.image = meme.memedImage;
        cell.memeLabel.text = "\(meme.topField)...\(meme.bottomField)";
        return cell;
    }
}
