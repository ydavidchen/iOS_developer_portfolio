//  ViewController.swift
//  BondVillains
//  Created by Jason on 11/19/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import UIKit;
let PROTYPE_CELL_ID = "VillainCell";
let SBOARD_ID = "VillainDetailViewController";

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties & accessories
    let allVillains = Villain.allVillains;
    func getVillain(_ indexPath: IndexPath) -> Villain {
        // Helper function to reduce code duplication:
        let rowIndex = (indexPath as NSIndexPath).row;
        return self.allVillains[rowIndex];
    }
    
    // MARK: - UITableViewDataSource contract methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allVillains.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PROTYPE_CELL_ID)!;
        let villain = getVillain(indexPath);

        cell.textLabel?.text = villain.name;
        cell.imageView?.image = UIImage(named: villain.imageName);
        
        // Set details iff available
        cell.detailTextLabel?.text = "Scheme: \(villain.evilScheme)";
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)";
//        }
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Note Syntax!!
        // Instantiate DetailViewController:
        let detailViewController = self.storyboard!.instantiateViewController(identifier:SBOARD_ID) as! VillainDetailViewController;
        
        // Pass data:
        detailViewController.villain = getVillain(indexPath);
        
        // Present view to Nav Ctrler:
        self.navigationController!.pushViewController(detailViewController, animated:true);
    }
    
    
}
