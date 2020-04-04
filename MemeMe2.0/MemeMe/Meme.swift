//  Meme.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

struct Meme {
    //MARK: - Properties
    var topField: String;
    var bottomField: String;
    var imageName: String;

    //MARK: - Static properties for reference or as reusables
    static let ID_COLLECTION = "MyCollectionView"; //reusable
    static let ID_TABLE = "MyTableView"; //reusable; shared in TableViewCell & CollectionViewCell
    static let topFieldKey = "Top";
    static let bottomFieldKey = "Bottom";
    static let imageKey = "ImageKey";
    static let ERROR_TAG = "Something went wrong!"; //for debugging
    
    
    //MARK: - Reusable static methods to reduce code duplication & increase consistency
    static func getMeme(_ memes:[Meme], _ indexPath: IndexPath) -> Meme {
        let rowIndex = (indexPath as NSIndexPath).row;
        return memes[rowIndex];
    }
    
    static func navigateByStoryboard(storyBoard:UIStoryboard, navController:UINavigationController, indexPath:IndexPath, memes:[Meme]) {
        let sentMemeVC = storyBoard.instantiateViewController(identifier:Meme.ID_COLLECTION) as! ViewController;
        sentMemeVC.meme = Meme.getMeme(memes, indexPath);
        navController.pushViewController(sentMemeVC, animated:true);
    }
    
    
    //MARK: - Constructor
    init(dictionary: [String:String]) {
        // Set properties:
        self.topField = dictionary[Meme.topFieldKey]!;
        self.bottomField = dictionary[Meme.bottomFieldKey]!;
        self.imageName = dictionary[Meme.imageKey]!;
    }
}
