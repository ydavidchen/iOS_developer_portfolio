//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        emailTextField.text = "";
        passwordTextField.text = "";
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Get the request token (either via helper method or closure):
        TMDBClient.getRequestToken(completion:handleRequestTokenResponse(success:error:));
        // performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    @IBAction func loginViaWebsiteTapped() {
        // performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    
    // MARK: Handlers
    func handleRequestTokenResponse(success:Bool, error:Error?) {
        if success {
            print(TMDBClient.Auth.requestToken);
        }
    }
}
