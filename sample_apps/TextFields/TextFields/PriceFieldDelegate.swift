//  PriceFieldDelegate.swift
//  TextFields
//
//  Created by DavidKevinChen on 3/28/20.
//  Copyright © 2020 Udacity. All rights reserved.

import Foundation;
import UIKit;

class PriceFieldDelegate: NSObject, UITextFieldDelegate {
    // MARK: - Accessories e.g. helper methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {textField.text = "$0.00";}
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    func dollarStringFromInt(_ value: Int) -> String {return String(value / 100);}
    func centsStringFromInt(_ value: Int) -> String {
        let cents = value % 100
        var centsString = String(cents)
        if cents < 10 {centsString = "0" + centsString}
        return centsString;
    }
    
    //MARK: - Core Method
    func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Construct the text that will be in the field if this change is accepted
        let oldText = textField.text! as NSString;
        var newText = oldText.replacingCharacters(in: range, with: string);
        let newTextString = String(newText); //copy required?
        
        // Extract & format numbers:
        let digits = CharacterSet.decimalDigits;
        var digitText = "";
        for char in newTextString.unicodeScalars {
            if digits.contains(UnicodeScalar(char.value)!) {
                digitText.append("\(char)")
            }
        }
        
        if let amount = Int(digitText) {
            newText = "$" + self.dollarStringFromInt(amount) + "." + self.centsStringFromInt(amount);
        } else {
            newText = "$0.00";
        }
        
        textField.text = newText;
        return false;
    }
}
