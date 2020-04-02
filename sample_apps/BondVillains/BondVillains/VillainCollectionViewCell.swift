//  VillainCollectionViewCell.swift
//  BondVillains
//  Created by DavidKevinChen on 4/2/20.
//  Copyright © 2020 Udacity. All rights reserved.

import UIKit;

class VillainCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties & Outlets
    var villain: Villain!; //not needed but won't hurt
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var label: UILabel!;
    
    // No further action necessary: image & label setting handled by CollectionView::collectionView contract methods
}
