//  ViewController.swift
//  MemeMe
//  Created by DavidKevinChen on 3/29/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    /* MARK: - UI Widgets & Properties */
    var meme = [Meme]();
    
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var topTextField: UITextField!;
    @IBOutlet weak var bottomTextField: UITextField!;
    @IBOutlet weak var bottomToolbar: UIToolbar!;
    @IBOutlet weak var cameraButton: UIBarButtonItem!;
    @IBOutlet weak var shareButton: UIBarButtonItem!; //disable for MemeMe1.0
    @IBOutlet weak var cancelButton: UIBarButtonItem!;
    
//    struct Meme {
//        var topText: String
//        var bottomText: String
//        var originalImg: UIImage
//        var memedImage: UIImage
//    }
    
    let ERROR_TAG = "Something went wrong!"; //for debugging
    let MEME_TEXT_ATTR: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-CondensedBlack", size:40)!,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.strokeColor: UIColor.gray,
        NSAttributedString.Key.strokeWidth: 0.5
    ];
    
    /* MARK: - ViewController lifecycle custom, & helper methods */
    override func viewDidLoad() {
        super.viewDidLoad();
        
        topTextField.text = "TOP";
        bottomTextField.text = "BOTTOM";
        topTextField.textAlignment = NSTextAlignment.center;
        bottomTextField.textAlignment = NSTextAlignment.center;
        topTextField.defaultTextAttributes = MEME_TEXT_ATTR;
        bottomTextField.defaultTextAttributes = MEME_TEXT_ATTR;
    
        topTextField.delegate = self;
        bottomTextField.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera);
        subscribeToKeyboardNotif();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        unsubscribeToKeyboardNotif();
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
    
    @IBAction func pickCameraImg(_ sender: Any) {
        let cameraImgPicker = UIImagePickerController();
        cameraImgPicker.delegate = self;
        cameraImgPicker.sourceType = .camera;
        present(cameraImgPicker, animated:true, completion:nil);
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

    func save() {
        // Create the meme
        let meme = Meme(top: topField.text!, bottom: bottomField.text!, image: imageView.image, memedImage: memedImage);

        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate;
        let appDelegate = object as! AppDelegate;
        appDelegate.memes.append(meme);
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        self.bottomTextField.text = "";
        self.topTextField.text = "";
        self.imageView.image = assembleMeme();
        self.imageView.contentMode = .scaleAspectFill;
    }
    
    /* MARK: - Methods to customize keyboards */
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            // Shift keyboard ONLY when the bottom textfield is being used
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
        if textField.isFirstResponder && (textField.text == "TOP" || textField.text == "BOTTOM") {
            textField.text = "";
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        if textField.text == "" {
            if textField.restorationIdentifier == "topTextField" {
                textField.text = "TOP";
            } else if textField.restorationIdentifier == "bottomTextField" {
                textField.text = "Bottom";
            }
        }
        return true;
    }
    
    let appDelegates = UIApplication.shared.delegate as! AppDelegate;
    memes = AppDelegate.memes;
}
