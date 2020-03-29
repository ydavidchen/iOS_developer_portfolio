//  ViewController.swift
//  MemeMe
//  Version: 1.0
//  References: Lesson 5: UIKit Fundamentals
//  Created by DavidKevinChen on 3/29/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    /* MARK: - UI Widgets & Properties */
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var topTextField: UITextField!;
    @IBOutlet weak var bottomTextField: UITextField!;
    
    let ERROR_TAG = "Something went wrong!";
    let MEME_TEXT_ATTR: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 0.25
    ];
    
    /* MARK: - ViewController Methods */
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Initialize TextFields
        topTextField.text = "TOP";
        bottomTextField.text = "BOTTOM";
        topTextField.textAlignment = NSTextAlignment.center;
        bottomTextField.textAlignment = NSTextAlignment.center;
        topTextField.defaultTextAttributes = MEME_TEXT_ATTR;
        bottomTextField.defaultTextAttributes = MEME_TEXT_ATTR;
    
        topTextField.delegate = self;
        bottomTextField.delegate = self;
    }

    /* MARK: - Methods to customize keyboards */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        subscribeToKeyboardNotif();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        unsubscribeToKeyboardNotif();
    }
    
    /* MARK: - Methods to handle image selection */
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self; //implemented below
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true, completion:nil);
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification);
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0;
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue;
        return keyboardSize.cgRectValue.height;
    }
    
    func subscribeToKeyboardNotif() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object:nil);
    }
    
    func unsubscribeToKeyboardNotif() {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object:nil);
    }
    
    
    /* MARK: - Image Picker Delegate */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil);
            imageView.image = image;
        } else {
            print("imagePickerController() " + ERROR_TAG);
            dismiss(animated: true, completion: nil);
        }
    }
    
    /* MARK: - TextField Delegate */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != "" {
            textField.text = "";
            textField.becomeFirstResponder();
        } else {
            print("textFieldDidBeginEditing() " + ERROR_TAG);
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
