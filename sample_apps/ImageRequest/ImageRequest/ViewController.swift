//  ViewController.swift
//  ImageRequest
//  Created by DavidKevinChen on 4/8/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

class ViewController: UIViewController {
    // MARK: - UI properties
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var loadImage: UIButton!;
    
    // MARK: - OBJECTS, either ENUM or STRUCT/CLASS w/ STATIC LET's
    enum kittenImgLocation: String {
        // Given by Udacity
        case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg";
        case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg";
        case error = "not a url";
    }
    
    enum MSGS: String {
        case DEBUG = "DEBUG: "
        case ERROR = "ERROR: "
        case INFO = "INFO: "
    }
    
    let imageLoc = kittenImgLocation.http.rawValue;
    
    // MARK: - Methods
    @IBAction func handleLoadImagePressed(_ sender: Any) {
        //Create URL
        guard let imageUrl = URL(string: imageLoc) else {
            print("Cannot create URL!");
            return;
        };
        
        // Create task w/ Completion Handler:
        let task = URLSession.shared.downloadTask(with: imageUrl) {(location, response, error) in
            guard let location = location else {
                print("Location is nil!");
                return;
            }
            print(MSGS.DEBUG.rawValue + location.absoluteString);
            
            let imageData = try! Data(contentsOf: location);
            let image = UIImage(data: imageData);
            DispatchQueue.main.async {
                self.imageView.image = image;
            }
        }
        
        // Task is automatically in suspended state
        // So we need explicit resume statement
        task.resume();
    }
    
}

