//  LoginViewController.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

class LoginViewController: UIViewController {
    //MARK: - UI elemtents
    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var loginButton: UIButton!;
    @IBOutlet weak var loginViaWebsiteButton: UIButton!;
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!;
    
    //MARK: - Actions
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
        setLoggingIn(true);
        TMDBClient.getRequestToken {(success,error) in
            if success {
                UIApplication.shared.open(
                    TMDBClient.Endpoints.webAuth.url,
                    options: [:],
                    completionHandler: nil
                );
            }
        }
    }
    
    
    //MARK: - Completion handlers
    func handleRequestTokenResponse(success:Bool, error:Error?) {
        if success {
            print("DEBUG: handleRequestTokenResponse() called");
            TMDBClient.login(
                username: self.emailTextField.text ?? "",
                password: self.passwordTextField.text ?? "",
                completion: self.handleLoginResponse(success:error:)
            );
            print("INFO: Auth request_token within handleRequestResponse(): " + TMDBClient.Auth.requestToken);
        } else {
            showLoginFailure(msg:error?.localizedDescription ?? "");
        }
    }
    
    func handleLoginResponse(success:Bool, error:Error?) {
        if success {
            print("DEBUG: handleLoginResponse() called");
            print("INFO: Auth request_token within handleLoginResponse(): " + TMDBClient.Auth.requestToken);
            TMDBClient.createSessionId(completion:handleSessionResponse(success:error:));
        } else {
            showLoginFailure(msg: error?.localizedDescription ?? "");
        }
    }
    
    func handleSessionResponse(success:Bool, error:Error?) {
        print("DEBUG: handleSessionResponse() called");
        setLoggingIn(false); //UI
        if success {
            print("INFO: Auth sessionId=" + TMDBClient.Auth.sessionId);
            self.emailTextField.text = "";
            self.passwordTextField.text = "";
            self.performSegue(withIdentifier:"completeLogin", sender:nil);
        } else {
            showLoginFailure(msg: error?.localizedDescription ?? "");
        }
    }
    
    /*
     UI helper methods
     */
    func setLoggingIn(_ loggingIn: Bool) {
        print("DEBUG: setLoggingIn() called");
        
        // Animates spinner:
        if loggingIn {
            activityIndicator.startAnimating();
        } else {
            activityIndicator.stopAnimating();
        }
        
        // Disable UI elements:
        emailTextField.isEnabled = !loggingIn;
        passwordTextField.isEnabled = !loggingIn;
        loginButton.isEnabled = !loggingIn
        loginViaWebsiteButton.isEnabled = !loggingIn;
    }
    
    func showLoginFailure(msg:String) {
        let alertVC = UIAlertController(title:"Login Failed", message:msg, preferredStyle:.alert);
        alertVC.addAction(UIAlertAction(title:"OK", style:.default, handler:nil));
        show(alertVC, sender:nil);
    }
}
