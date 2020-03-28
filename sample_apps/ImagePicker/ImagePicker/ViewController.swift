//
//  ViewController.swift
//  ImagePicker
//
//  Created by DavidKevinChen on 3/28/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var showGalleryButton: UIButton!
    
    //MARK: - Built-in Methods
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    //MARK: - Custom action/methods
    @IBAction func experiment() {
        let nextController = UIImagePickerController();
        present(nextController, animated: true, completion: nil);
    }
}

