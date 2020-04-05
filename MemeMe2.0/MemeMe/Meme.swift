//  Meme.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

struct Meme {
    //MARK: - Properties
    var topField: String;
    var bottomField: String;
    var image: UIImage;
    var memedImage: UIImage;

    //MARK: - Static properties for reference
    static let topFieldKey = "Top";
    static let bottomFieldKey = "Bottom";
    static let imageKey = "ImageKey";
    static let MEME_TEXT_ATTR: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-CondensedBlack", size:40)!,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.strokeColor: UIColor.gray,
        NSAttributedString.Key.strokeWidth: 0.5
    ];
    
    //MARK: - Constructor
    init(_ top:String, _ bottom:String, _ image:UIImage, _ memedImage:UIImage?=nil) {
        self.topField = top;
        self.bottomField = bottom;
        self.image = image;
        self.memedImage = memedImage!;
    }
}
