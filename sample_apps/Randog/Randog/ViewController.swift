//  ViewController.swift
//  Randog
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;
import Foundation;

/**
Extension to use & customize data fetching from Web API
*/
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var pickerView: UIPickerView!;
    let breeds: [String] = ["greyhound", "poodle"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        pickerView.dataSource = self;
        pickerView.delegate = self;
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

/**
Extension to handle use PickerView API
*/
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // Populates picker view UI:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Number of sections in the table
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count;
    }
    
    // Populates information regarding view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Called when the Picker View stops spinning
        // We want to fetch an image from the Dog API
        DogAPI.requestRandomImage(completionHandler:handleRandomImgResponse(imageData:error:));
    }
    
}
