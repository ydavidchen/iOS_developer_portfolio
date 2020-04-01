//  VillainDetailViewController.swift
//  BondVillains
//  Created by DavidKevinChen on 4/1/20.
//  Copyright © 2020 Udacity. All rights reserved.

import UIKit;

class VillainDetailViewController: UIViewController {
    // MARK: - Properties
    var villain: Villain!; //unwrapped optional REQUIERD to avoid compile-time error
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var masterDetailText: UILabel!
    
    // MARK: - Actions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.masterDetailText.text = villain.name;
        self.imageView.image = UIImage(named: villain.imageName);
    }
}
