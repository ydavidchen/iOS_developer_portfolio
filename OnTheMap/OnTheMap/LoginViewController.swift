//  LoginViewController.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;
import Foundation;

class LoginViewController: UIViewController {
    //MARK: - Outlet UI
    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var loginButton: UIButton!;
    @IBOutlet weak var signupButton: UIButton!;
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    //MARK: - Outlet Actions
    @IBAction func loginTapped(_ sender: Any) {
        setLogin(true);
        
        // DEVELOPMENT MODE: To streamline login, bypass the formal authentication process
        handleLoginResponse(success:true, error:nil);
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        guard let url = URL(string:AccountClient.LINK_SU) else {return;}
        UIApplication.shared.open(url);
    }
    
    //MARK: - Callbacks/completion handlers
    func handleRequestTokenResponse(success:Bool, error:Error?) {
        if success {
            print("AccountClient.login() called");
            DispatchQueue.main.async {
                AccountClient.login(
                    username: self.emailTextField.text ?? "",
                    password: self.passwordTextField.text ?? "",
                    completion: self.handleLoginResponse(success:error:)
                );
            }
        } else {
            alertFailedLogin(message: error?.localizedDescription ?? "Unknown error");
        }
    }
    
    func handleLoginResponse(success:Bool, error:Error?) {
        setLogin(false);
        if success {
            performSegue(withIdentifier:"completeLogin", sender:nil);
        } else {
            alertFailedLogin(message: error?.localizedDescription ?? "Unknown error");
        }
    }
    
    //MARK: - Helper/wrapper methods
    func setLogin(_ loggingIn:Bool) {
        emailTextField.isEnabled = !loggingIn;
        passwordTextField.isEnabled = !loggingIn;
        loginButton.isEnabled = !loggingIn;
    }
    
    func alertFailedLogin(message:String) {
        let alertVC = UIAlertController(title:"Login failed!", message:message, preferredStyle:.alert);
        alertVC.addAction(UIAlertAction(title:"Dismiss", style:.default, handler: nil));
        show(alertVC, sender: nil);
    }
    
}
