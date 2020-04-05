//  Constants.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

struct Constants {
    static let ERROR_TAG = "Something went wrong!"; //for debugging
    
    //MARK: - Storyboard keys:
    static let ID_COLLECTIONVIEW = "CollectionViewController"; //reusable
    static let ID_TABLEVIEW = "TableViewController";
    static let ID_SENT_MEME = "SentMemeViewController"; //reusable; shared in TableViewCell & CollectionViewCell
    static let ID_TABBAR = "TabBarController";
    
    //MARK: - Reusable static methods to reduce code duplication & increase consistency
    static func getMeme(_ memes:[Meme], _ indexPath: IndexPath) -> Meme {
        // Helper function to get `indexPath`-th meme by passing in a dictionary of Memes
        let rowIndex = (indexPath as NSIndexPath).row;
        return memes[rowIndex];
    }
    
    static func triggerSentMemeVC(_ sb:UIStoryboard, _ nvc:UINavigationController) {
        // Helper function to bring up trigger SentMemeViewController
        // Usage: triggerSentMemeVC(self.storyboard, self.navigationController);
        let sentMemeVC = sb.instantiateViewController(identifier:Constants.ID_SENT_MEME) as! SentMemeViewController;
        nvc.pushViewController(sentMemeVC, animated:true);
    }
}
