//  RandomColorTextFieldDelegate.swift
//  TextFields : Challenge Functionality
//  Created by DavidKevinChen on 3/28/20.
//  Copyright © 2020 Udacity. All rights reserved.

import Foundation;
import UIKit;

class RandomColorTextFieldDelegate: NSObject, UITextFieldDelegate {
    //MARK: - Properties:
    let colors:[UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .brown];
    
    /* MARK: - Suggested Custom Methods */
    func randomColor() -> UIColor {
        let randomIndex = Int(arc4random() % UInt32(colors.count));
        return colors[randomIndex];
    }
    
    func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = randomColor();
        return true;
    }
}
