//
//  ChallengeAppTextFieldDelegate.swift
//  TextFields
//
//  Created by DavidKevinChen on 3/28/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation;
import UIKit;

class ChallengeAppTextFieldDelegate: NSObject, UITextFieldDelegate {
    //MARK: - Properties
    
    //MARK: - Methods
    func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
}
