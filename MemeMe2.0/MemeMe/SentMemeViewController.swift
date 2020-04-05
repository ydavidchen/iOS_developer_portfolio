//  SentMemeViewController.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

class SentMemeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    //MARK: - Properites & UI elements
    var meme: Meme!;
    
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var topTextField: UITextField!;
    @IBOutlet weak var bottomTextField: UITextField!;
    @IBOutlet weak var bottomToolbar: UIToolbar!;
    @IBOutlet weak var cameraButton: UIBarButtonItem!;
    @IBOutlet weak var shareButton: UIBarButtonItem!;
    @IBOutlet weak var cancelButton: UIBarButtonItem!;
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Default UI appearance:
        topTextField.text = "TOP";
        bottomTextField.text = "BOTTOM";
        topTextField.defaultTextAttributes = Meme.MEME_TEXT_ATTR;
        bottomTextField.defaultTextAttributes = Meme.MEME_TEXT_ATTR;
        
        // Assign TableView delegate implemented in this script:
        topTextField.delegate = self;
        bottomTextField.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        subscribeToKeyboardNotif();
        
        // Default UI element appearances:
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera); //display IF available
        self.tabBarController?.tabBar.isHidden = true; //all times
        self.shareButton?.isEnabled = false; //will change later
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        unsubscribeToKeyboardNotif();
    }
    
    //MARK: - Helper functions for abstraction:
    func saveMeme(_ meme2Save:Meme) {
        //Helper to pass current meme data to AppDelegate for sharing across other VCs
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.memes.append(meme2Save);
        
        //TODO: Save to gallery:
        //UIImageWriteToSavedPhotosAlbum(meme2Save.memedImage, self, #selector(imagePickerController(_:didFinishPickingMediaWithInfo:)), nil);
        
        //TODO: Bring out iOS Message App:
        //let activityVC = UIActivityViewController(activityItems:[meme2Save.memedImage], applicationActivities:nil);
        //self.present(activityVC, animated:true, completion:nil);
    }
    
    func coSetNavAndToolbar(hide:Bool) {
        //Helper method to reduce code duplication
        navigationController?.setNavigationBarHidden(hide, animated:false);
        self.bottomToolbar.isHidden = hide;
        bottomTextField.isHidden = !hide;
        topTextField.isHidden = !hide;
    }
    
    func returnToRoot() {
        //Helper method to reduce code duplication
        self.dismiss(animated:true, completion:nil);
        self.navigationController?.popViewController(animated:true);
    }

    
    //MARK: - Methods to handle a meme
    func pickImageHelper(_ sourceType:UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = sourceType;
        present(imagePicker, animated:true, completion:nil); //present image
        self.shareButton?.isEnabled = true; //enable Share Button
    }
    @IBAction func pickImgFromAlbum(_ sender: Any) {pickImageHelper(.photoLibrary);}
    @IBAction func takeCameraPhoto(_ sender: Any) {pickImageHelper(.camera);}
    
    func createMemedImage() -> UIImage {
        // Wrapper function
        coSetNavAndToolbar(hide:true);

        UIGraphicsBeginImageContext(self.view.frame.size);
        view.drawHierarchy(in:self.view.frame, afterScreenUpdates:true);
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();

        coSetNavAndToolbar(hide:false);
        return memedImage;
     }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = createMemedImage();
        let meme2Save = Meme(topTextField.text ?? "", bottomTextField.text ?? "", memedImage);
        saveMeme(meme2Save);
        
        self.imageView.image = memedImage;
        self.imageView.contentMode = .scaleAspectFill;
        
        returnToRoot();
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        returnToRoot();
    }
    
    
    //MARK: - Methods to customize keyboards
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
    
    
    //MARK: - ImagePicker delegate method implementations
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image;
        } else {
            print("imagePickerController() " + Constants.ERROR_TAG);
        }
        dismiss(animated: true, completion: nil);
    }
    
    //MARK: - TextFieldDelegate method implementations
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
    
}
