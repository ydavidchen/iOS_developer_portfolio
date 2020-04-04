//  Meme.swift
//  MemeMe
//
//  Created by DavidKevinChen on 4/1/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

struct Meme {
    //MARK: - Properties
    var topField: String;
    var bottomField: String;
    var imageName: String;

    //MARK: - Static objects
    static let SBOARD_ID = "ViewController"; //reusable
    static let PROTYPE_CELL_ID = "TableViewCell"; //reusable; shared in TableViewCell & CollectionViewCell
    static let topFieldKey = "Top";
    static let bottomFieldKey = "Bottom";
    static let imageKey = "ImageKey";
    static let ERROR_TAG = "Something went wrong!"; //for debugging
    
    //MARK: - Constructor
    init(dictionary: [String:String]) {
        // Set properties:
        self.topField = dictionary[Meme.topFieldKey]!;
        self.bottomField = dictionary[Meme.bottomFieldKey]!;
        self.imageName = dictionary[Meme.imageKey]!;
    }
}
