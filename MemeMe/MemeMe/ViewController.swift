//  ViewController.swift
//  MemeMe
//  Version: 1.0
//  References: Lesson 5: UIKit Fundamentals
//  Created by DavidKevinChen on 3/29/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.


/** Note about simulator (iPhone 11 Pro Max) -- PLEASE READ WHEN GRADING!!!
In my simulator, the keyboard is by default linked to my Laptop keyboard.
Simply uncheck the simulator-laptop keyboard linking the Simulator once won't fix the issue.
However, if I repeat this action for another time, the simulator's keyboard will turn on.
This would ONLY happen when I try to test the app for the first time on Xcode startup.
*/

import UIKit;

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    /* MARK: - UI Widgets & Properties */
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var topTextField: UITextField!;
    @IBOutlet weak var bottomTextField: UITextField!;
    @IBOutlet weak var bottomToolbar: UIToolbar!; //bottom toolbar
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImg: UIImage
        var memedImage: UIImage
    }
    
    let ERROR_TAG = "Something went wrong!";
    let MEME_TEXT_ATTR: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-CondensedBlack", size:40)!,
        NSAttributedString.Key.strokeWidth: 0.25
    ];
    
    
    /* MARK: - ViewController overriden, custom, & helper methods */
    override func viewDidLoad() {
        super.viewDidLoad();
        
        topTextField.text = "";
        bottomTextField.text = "";
        topTextField.textAlignment = NSTextAlignment.center;
        bottomTextField.textAlignment = NSTextAlignment.center;
        topTextField.defaultTextAttributes = MEME_TEXT_ATTR;
        bottomTextField.defaultTextAttributes = MEME_TEXT_ATTR;
    
        topTextField.delegate = self;
        bottomTextField.delegate = self;
    }
    
    func coSetNavAndToolbar(hide: Bool) { //helper
        navigationController?.setNavigationBarHidden(hide, animated: false);
        self.bottomToolbar.isHidden = hide;
    }

    /* MARK: - Methods to handle memes */
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated:true, completion:nil);
    }
    
    func assembleMeme() -> UIImage {
        coSetNavAndToolbar(hide: true);

        UIGraphicsBeginImageContext(self.view.frame.size);
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();

        coSetNavAndToolbar(hide: false);
        return memedImage;
     }
    
//    func saveMeme() {
//        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage);
//    }
     

    /* MARK: - Methods to customize keyboards */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        subscribeToKeyboardNotif();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        unsubscribeToKeyboardNotif();
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if topTextField.isFirstResponder || bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification);
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if !(topTextField.isFirstResponder && bottomTextField.isFirstResponder) {
            view.frame.origin.y = 0;
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue;
        return keyboardSize.cgRectValue.height;
    }
    
    func subscribeToKeyboardNotif() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object:nil);
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object:nil);
    }
    
    func unsubscribeToKeyboardNotif() {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object:nil);
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object:nil);
    }
    
    
    /* MARK: - Delegate methods for ImagePicker */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image;
        } else {
            print("imagePickerController() " + ERROR_TAG);
        }
        dismiss(animated: true, completion: nil);
    }
    
    /* MARK: - Delegate methods for TextFields */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
