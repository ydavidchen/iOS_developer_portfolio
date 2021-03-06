//  MapViewController.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;
import Foundation;

class MapViewController: UIViewController {
    //MARK: - Outlets
    
    //MARK: - Fields/Properties
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    //MARK: Actions
    //@note: Currently, LOGOUT functionality is only on 1 tab, which could be extended to the table view via brute-force method
    @IBAction func logoutTapped(_ sender: Any) {
        AccountClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated:true, completion:nil);
            }
        }
    }
    
}

