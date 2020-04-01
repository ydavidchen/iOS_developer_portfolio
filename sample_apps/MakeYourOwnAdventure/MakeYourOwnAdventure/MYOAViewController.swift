//  MYOAViewController.swift
//  MakeYourOwnAdventure
//  Created by DavidKevinChen on 4/1/20.
//  Copyright © 2020 Udacity. All rights reserved.

import Foundation;
import UIKit;

class MYOAViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Start Over",
            style: .plain,
            target: self,
            action: #selector(startOver)
        );
    }
    
    @objc func startOver() {
        // Navigates back to the root UI of the app
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true);
        }
    }
    
    deinit { //ONLY available in Swift classes, not structs
        // Debugging method
        print("ViewController de-allocated");
    }
}
