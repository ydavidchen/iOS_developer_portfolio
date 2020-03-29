//  EmojiTextFieldDelegate.swift
//  TextFields
//
//  Created by Jason on 11/11/14.
//  Copyright (c) 2014 Udacity. All rights reserved.

import Foundation;
import UIKit;

class EmojiTextFieldDelegate : NSObject, UITextFieldDelegate {
    //MARK: - Accessories
    var translations = [String : String]()
    override init() {
        super.init()
        translations["heart"] = "\u{0001F496}"
        translations["fish"] = "\u{E522}"
        translations["bird"] = "\u{E523}"
        translations["frog"] = "\u{E531}"
        translations["bear"] = "\u{E527}"
        translations["dog"] = "\u{E052}"
        translations["cat"] = "\u{E04F}"
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {textField.text = "";}
    
    //MARK: - Core method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var replacedAnEmoji = false
        var emojiStringRange: NSRange
        
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        for (emojiString, emoji) in translations {
            repeat {
                emojiStringRange = newText.range(of: emojiString, options: .caseInsensitive)
                if emojiStringRange.location != NSNotFound {
                    newText = newText.replacingCharacters(in: emojiStringRange, with: emoji) as NSString
                    replacedAnEmoji = true
                }
                
            } while emojiStringRange.location != NSNotFound
        }

        if replacedAnEmoji {
            textField.text = newText as String;
            return false;
        } else {
            return true;
        }
    }
}
