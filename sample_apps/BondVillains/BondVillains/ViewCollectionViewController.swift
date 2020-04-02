//
//  ViewCollectionViewController.swift
//  BondVillains
//
//  Created by DavidKevinChen on 4/2/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit;

class ViewCollectionViewController: UICollectionViewController {
    let allVillains = Villain.allVillains;
    
    //MARK: - Customize lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false; //turn tab bar ON by default
    }

    //MARK: - CollectionView contract methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allVillains.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Same as tableView in ViewDetailViewController
        let detailViewController = self.storyboard!.instantiateViewController(identifier:Villain.SBOARD_ID) as! VillainDetailViewController;
        detailViewController.villain = Villain.getVillain(allVillains, indexPath);
        self.navigationController!.pushViewController(detailViewController, animated:true);
    }
}
