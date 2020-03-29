//
//  ViewController.swift
//  ImagePicker2
//
//  Created by DavidKevinChen on 3/29/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

import UIKit;

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    /*MARK: - Basic UI Controller elements */
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var topTextField: UITextField!;
    @IBOutlet weak var bottomTextField: UITextField!;
    
    let ERROR_TAG = "Something went wrong!";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Set initial texts:
        topTextField.text = "TOP";
        bottomTextField.text = "BOTTOM";
        topTextField.textAlignment = NSTextAlignment.center;
        topTextField.textAlignment = bottomTextField.textAlignment;
        
        // Set text delegate:
        topTextField.delegate = self;
        bottomTextField.delegate = self;
    }

    @IBAction func pickImage(_ sender: Any) {
        //Launch image picker controller - note syntax
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self; //implemented below
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true, completion:nil);
    }
    
    /* MARK: - Image Picker Delegate Contract */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil);
            imageView.image = image;
        } else {
            print(ERROR_TAG);
            dismiss(animated: true, completion: nil);
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
    }
    
    //TODO: - Camera button?
    
    /* MARK: - Text Field Delegate Contract */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextField.text != "" {
            topTextField.text = "";
        } else if bottomTextField.text != "" {
            bottomTextField.text = "";
        } else {
            print(ERROR_TAG);
        }
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topTextField.resignFirstResponder();
        bottomTextField.resignFirstResponder();
        return true;
    }
}
