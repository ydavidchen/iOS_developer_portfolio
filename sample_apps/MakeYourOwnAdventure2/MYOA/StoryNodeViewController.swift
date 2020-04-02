//  StoryNodeViewController.swift
//  MYOA
//  Created by Jarrod Parkes on 11/2/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import UIKit;
let TABLE_CELL_ID = "Cell";
let SBOARD_ID = "StoryNodeViewController";

class StoryNodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties & outlets
    var storyNode: StoryNode!;

    @IBOutlet weak var adventureImageView: UIImageView!;
    @IBOutlet weak var messageTextView: UITextView!;
    @IBOutlet weak var tableView: UITableView!;
    @IBOutlet weak var restartButton: UIButton!;
    
    static func formatIndex(_ indexPath: IndexPath) -> Int {
        // Reusable static helper to reduce code duplication
        let rowIndex = (indexPath as NSIndexPath).row;
        return rowIndex;
    }
    
    func getAnyStoryPrompt(_ indexPath:IndexPath, next:Bool) -> String {
        var index = StoryNodeViewController.formatIndex(indexPath);
        if next {index += 1;}
        return self.storyNode.promptForIndex(index);
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Set image & text:
        if let imageName = storyNode.imageName {
            self.adventureImageView.image = UIImage(named: imageName);
        }
        self.messageTextView.text = storyNode.message;
        
        //TODO: Hide the restart button if there are choices to be made NOTE SYNTAX!!!
        restartButton.isHidden = storyNode.promptCount() > 0;
    }
    
    //MARK: - TableView delegate & datasource contract methods TEMPLATE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of prompts in the storyNode
        return storyNode.promptCount();
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Dequeue a cell and populate it with text from the correct prompt
        let cell = tableView.dequeueReusableCell(withIdentifier:TABLE_CELL_ID)!;
        cell.textLabel!.text = getAnyStoryPrompt(indexPath, next:false);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Implement to push the next StoryNode
        // Instantiate view controller, customized based on StoryNode Class given
        let viewController = self.storyboard?.instantiateViewController(identifier:SBOARD_ID) as! StoryNodeViewController;
        
        // Set StoryNode:
        viewController.storyNode = self.storyNode.storyNodeForIndex(index: StoryNodeViewController.formatIndex(indexPath));
        
        // present view to NavCtrler
        self.navigationController?.pushViewController(viewController, animated:true);
    }

    //MARK: - Actions
    @IBAction func restartStory() {
        let controller = self.navigationController!.viewControllers[1];
        let _ = self.navigationController?.popToViewController(controller, animated:true);
    }
}
