//  ViewController.swift
//  TextFields
//  Created by Jason on 11/11/14.
//  Completed / polished by David Chen on 3/27/20
//  Copyright (c) 2014 Udacity. All rights reserved.

import UIKit;

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var textField1: UITextField!;
    @IBOutlet weak var textField2: UITextField!;
    @IBOutlet weak var textField3: UITextField!;
    @IBOutlet weak var zipField: UITextField!;
    @IBOutlet weak var priceField: UITextField!;
    
    @IBOutlet weak var characterCountLabel: UILabel!;
    @IBOutlet weak var restrictSwitch: UISwitch!;
    
    // MARK: Properties (initialised delegates)
    let emojiDelegate = EmojiTextFieldDelegate();
    let colorizerDelegate = ColorizerTextFieldDelegate();
    let randomColorDelegate = RandomColorTextFieldDelegate();
    let priceFieldDelegate = PriceFieldDelegate();
    
    // MARK: App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        self.characterCountLabel.isHidden = true;
        
        // Set delegates:
        self.textField1.delegate = emojiDelegate;
        self.textField2.delegate = colorizerDelegate;
        self.textField3.delegate = self;
        
        // Delegates for the challenge app component:
        self.zipField.delegate = randomColorDelegate;
        self.priceField.delegate = priceFieldDelegate;
        
        self.restrictSwitch.setOn(false, animated:false);
    }
    
    /* MARK: - Core & accessory methods for switch-controlled TextView delegate */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString;
        
        self.characterCountLabel.isHidden = (newText.length == 0);
        self.characterCountLabel.text = String(newText.length);
        return true;
    }
    
    @IBAction func allowText(_ sender: Any) {
        if !(sender as! UISwitch).isOn {
            self.textField3.resignFirstResponder();
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.restrictSwitch.isOn;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
