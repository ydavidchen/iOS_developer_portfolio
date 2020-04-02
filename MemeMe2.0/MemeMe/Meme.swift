//  Meme.swift
//  MemeMe
//
//  Created by DavidKevinChen on 4/1/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

class Meme {
    //MARK: - Properties
    var topField: String;
    var bottomField: String;
    var image: UIImage;
    var memedImage: UIImage;

    //MARK: - Constructor
    init(top:String, bottom:String, image:UIImage) {
        self.topField = top;
        self.bottomField = bottom;
        self.image = image;
        
        // Computed property
        self.memedImage = image; //initial value
    }
}
