//  VillainCollectionViewController.swift
//  BondVillains
//  Created by DavidKevinChen on 4/2/20.
//  Copyright © 2020 Udacity. All rights reserved.

import Foundation;
import UIKit;

class VillainCollectionViewController: UICollectionViewController {
    let allVillains = Villain.allVillains;
    
    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false;
    }
    
    //MARK: - CollectionViewDataSource contract methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allVillains.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let villain = self.allVillains[(indexPath as NSIndexPath).row];
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VillainCell", for:indexPath) as! VillainCollectionViewCell;
        
        // Set the name and image
        // cell.nameLabel?.text = villain.name;
        // cell.imageView?.image = UIImage(named: villain.imageName)
        
        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
        
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController;
        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row];
        self.navigationController!.pushViewController(detailController, animated: true);
    }
}

