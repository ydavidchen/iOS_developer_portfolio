//  LoginViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var loginButton: UIButton!;
    @IBOutlet weak var loginViaWebsiteButton: UIButton!;
    
    // MARK: - Actions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        emailTextField.text = "";
        passwordTextField.text = "";
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Get the request token (either via helper method or closure):
        TMDBClient.getRequestToken(completion:handleRequestTokenResponse(success:error:));
    }
    
    @IBAction func loginViaWebsiteTapped() {
        // performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    
    // MARK: - Completion handlers
    func handleRequestTokenResponse(success:Bool, error:Error?) {
        if success {
            print("DEBUG: handleRequestTokenResponse() called");
            DispatchQueue.main.async {
                TMDBClient.login(
                    username: self.emailTextField.text ?? "",
                    password: self.passwordTextField.text ?? "",
                    completion: self.handleLoginResponse(success:error:)
                );
                print("INFO: Auth request_token within handleRequestResponse(): " + TMDBClient.Auth.requestToken);
            }
        } else {
            print("ERROR: Failed to involke handleRequestTokenResponse()");
        }
    }
    
    func handleLoginResponse(success:Bool, error:Error?) {
        if success {
            print("DEBUG: handleLoginResponse() called");
            print("INFO: Auth request_token within handleLoginResponse(): " + TMDBClient.Auth.requestToken);
            TMDBClient.createSessionId(completion:handleSessionResponse(success:error:));
        }
    }
    
    func handleSessionResponse(success:Bool, error:Error?) {
        print("DEBUG: handleSessionResponse() called");
        if success {
            print("INFO: Auth sessionId=" + TMDBClient.Auth.sessionId);
            DispatchQueue.main.async {
                self.performSegue(withIdentifier:"completeLogin", sender:nil);
            }
        }
    }
}
