//  ViewController.swift
//  Randog
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;
import Foundation;

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        DogAPI.requestRandomImage(completionHandler:handleRandomImgResponse(imageData:error:));
    }
    
    //MARK: - Abstracted method for accessing API (outer async task)
    func handleRandomImgResponse(imageData:DogImage?, error:Error?) {
        guard let imageUrl = URL(string:imageData?.message ?? "") else {return;};
        DogAPI.requestImageFile(imageUrl:imageUrl, completionHandler:self.handleImgFileResponse(image:error:));
    }
    
    func handleImgFileResponse(image:UIImage?, error:Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image;
        }
    }

}

