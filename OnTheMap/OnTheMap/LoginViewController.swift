//  LoginViewController.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;
import Foundation;

class LoginViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var loginButton: UIButton!;
    @IBOutlet weak var signupButton: UIButton!;
    
    //MARK: - Fields/Properties
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction func loginTapped(_ sender: Any) {
        let isAuth = authenticate(emailTextField.text ?? "", passwordTextField.text ?? "");
        
        if isAuth {
            print("Continue to main page");
            // performSegue(withIdentifier:"MapViewController", sender:nil);
        } else {
            print("Authentication failed!");
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        let LINK_SU = "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated";
        guard let url = URL(string:LINK_SU) else {return;}
        UIApplication.shared.open(url);
    }
    
    //MARK: Helper/wrapper methods
    func authenticate(_ email:String, _ password:String) -> Bool {
        return true; //placeholder
    }
}
