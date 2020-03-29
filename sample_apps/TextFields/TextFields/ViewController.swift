//  ViewController.swift
//  TextFields
//  Created by Jason on 11/11/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

/*
 This lesson demonstrates TextView delegates (protocols/interfaces)
 Here, 3 used: 2 created as custom swift classes, one is just ths UIViewController
 Delegates for TextViews can be easily switched
 */

import UIKit;
class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    // MARK: Properties (initialised delegates)
    let emojiDelegate = EmojiTextFieldDelegate();
    let colorizerDelegate = ColorizerTextFieldDelegate();
    let randomColorDelegate = RandomColorTextFieldDelegate();
    
    // MARK: App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterCountLabel.isHidden = true;
        
        // Set delegates:
        self.textField1.delegate = emojiDelegate;
        self.textField2.delegate = colorizerDelegate;
        self.textField3.delegate = self;
        
        // Experiment with a delegate that I wrote:
        self.textField2.delegate = randomColorDelegate;
    }
    
    // MARK: Text Field UIVC Delegate Methods (3rd textfield)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString;
        
        self.characterCountLabel.isHidden = (newText.length == 0);
        self.characterCountLabel.text = String(newText.length);
        return true;
    }
}
