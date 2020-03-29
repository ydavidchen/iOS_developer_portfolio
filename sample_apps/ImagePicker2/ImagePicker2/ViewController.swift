//
//  ViewController.swift
//  ImagePicker2
//
//  Created by DavidKevinChen on 3/29/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

import UIKit;

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    /*MARK: - Basic UI Controller elements */
    @IBOutlet weak var imageView: UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    @IBAction func pickImage(_ sender: Any) {
        //Launch image picker controller - note syntax
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self; //implemented below
        present(imagePicker, animated: true, completion:nil);
    }
    
    /* MARK: - Image Picker Delegate Contract */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil);
            imageView.image = image;
        } else {
            let msg = "Image loading via k-v pair failed";
            print(msg);
            dismiss(animated: true, completion: nil);
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
    }
}

