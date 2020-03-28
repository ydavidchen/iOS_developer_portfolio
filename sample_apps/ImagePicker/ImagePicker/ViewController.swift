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
    @IBOutlet weak var showGalleryButton: UIButton!;
    @IBOutlet weak var showAlertButton: UIButton!;
    
    
    //MARK: - Built-in Methods
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    //MARK: - Custom actions/methods
    @IBAction func showGallery() {
        let nextController = UIImagePickerController();
        present(nextController, animated: true, completion: nil);
    }
    
    @IBAction func showAlert() {
        let alertControler = UIAlertController();
        
        // Create alert:
        alertControler.title = "TEST ALERT";
        alertControler.message = "This is a TEST";
        
        // Give user an option to close alert via a callback:
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default){
            action in self.dismiss(animated:true, completion: nil)
        };
        alertControler.addAction(okAction);
        
        present(alertControler, animated: true, completion: nil);
    }
}

