//  Villain.swift
//  BondVillains
//  Created by Jason on 11/19/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//  This is a CUSTOM OBJECT CLASS provided by Udacity, modified by ydavidchen

import Foundation;
import UIKit;

/**
Custom data model, with possibly of extension
*/
struct Villain {
    let name: String;
    let evilScheme: String;
    let imageName: String;
    
    static let NameKey = "NameKey";
    static let EvilSchemeKey = "EvilScheme";
    static let ImageNameKey = "ImageNameKey";
    static let SBOARD_ID = "VillainDetailViewController";
    static let PROTYPE_CELL_ID = "VillainCell"; //shared in both TableViewCell & CollectionViewCell
    
    init(dictionary: [String:String]) {
        self.name = dictionary[Villain.NameKey]!;
        self.evilScheme = dictionary[Villain.EvilSchemeKey]!;
        self.imageName = dictionary[Villain.ImageNameKey]!;
    }
}

/**
* Extension to add a static array of Villain objects
* Generates an array full of all of the villains
*/
extension Villain {
    static var allVillains: [Villain] {
        var villainArray = [Villain]();
        for d in Villain.localVillainData() {
            villainArray.append(Villain(dictionary: d));
        }
        return villainArray;
    }

    static func localVillainData() -> [[String: String]] {
        return [
            [Villain.NameKey : "Mr. Big", Villain.EvilSchemeKey : "Smuggle heroin.", Villain.ImageNameKey : "Big"],
            [Villain.NameKey : "Ernest Blofeld", Villain.EvilSchemeKey : "Many, many schemes.", Villain.ImageNameKey : "Blofeld"],
            [Villain.NameKey : "Sir Hugo Drax", Villain.EvilSchemeKey : "Nerve gas Earth from the Moon.", Villain.ImageNameKey : "Drax"],
            [Villain.NameKey : "Jaws", Villain.EvilSchemeKey : "Kill Bond with huge metal teeth.", Villain.ImageNameKey : "Jaws"],
            [Villain.NameKey : "Rosa Klebb", Villain.EvilSchemeKey : "Humiliate MI6.", Villain.ImageNameKey : "Klebb"],
            [Villain.NameKey : "Emilio Largo", Villain.EvilSchemeKey : "Steal nuclear weapons", Villain.ImageNameKey : "EmilioLargo"],
            [Villain.NameKey : "Le Chiffre", Villain.EvilSchemeKey : "Beat Bond at poker.", Villain.ImageNameKey : "Lechiffre"],
            [Villain.NameKey : "Odd Job", Villain.EvilSchemeKey : "Kill Bond with a razor hat.", Villain.ImageNameKey : "OddJob"],
            [Villain.NameKey : "Francisco Scaramanga", Villain.EvilSchemeKey : "Kill Bond after assembling a golden gun.", Villain.ImageNameKey : "Scaramanga"],
            [Villain.NameKey : "Raoul Silva", Villain.EvilSchemeKey : "Kill M.", Villain.ImageNameKey : "Silva"],
            [Villain.NameKey : "Alec Trevelyan", Villain.EvilSchemeKey : "Nuke London after killing Bond.", Villain.ImageNameKey : "Trevelyan"],
            [Villain.NameKey : "Auric Goldfinger", Villain.EvilSchemeKey : "Nuke Fort Knox.", Villain.ImageNameKey : "Goldfinger"],
            [Villain.NameKey : "Max Zorin", Villain.EvilSchemeKey : "Destroy Silicon Valley with an earthquake and flood.", Villain.ImageNameKey : "Zorin"]
        ];
    }
    
    static func getVillain(_ allVillains:[Villain], _ indexPath: IndexPath) -> Villain {
        // Reusable helper function to reduce code duplication
        let rowIndex = (indexPath as NSIndexPath).row;
        return allVillains[rowIndex];
    }
}
