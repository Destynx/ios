//
//  LoginViewController.swift
//  Les 1
//
//  Created by Maurice on 05/11/2017.
//  Copyright © 2017 Maurice. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    var webservice = WebService()
    @IBOutlet weak var statusField: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var passwordTextField: UILabel!
    @IBOutlet weak var usernameTextField: UILabel!
    
    var username : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func LoginButtonAction(_ sender: UIButton) {
        webservice.executeLogin(username : (usernameInput?.text)!,
                                password : (passwordInput?.text)!,
                                withSuccess: { (succes) in
            self.createPage()
        }, orFailure: { (error) in
            let message = UIAlertController(title: "Failure", message: "Username or Password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
            message.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            DispatchQueue.main.async {
                self.present(message, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        webservice.logout()
        self.createPage()
    }
    
    private func createPage() {
        if (self.webservice.isLoggedIn()) {
            DispatchQueue.main.async {
                self.usernameInput.isHidden = true
                self.passwordInput.isHidden = true
                self.loginButton.isHidden = true
                self.logoutButton.isHidden = false
                self.passwordTextField.isHidden = true
                self.usernameTextField.isHidden = true
                self.statusField.text = "Welkom \(self.usernameInput.text!)"
            }
        } else {
            DispatchQueue.main.async {
                self.usernameInput.isHidden = false
                self.passwordInput.isHidden = false
                self.loginButton.isHidden = false
                self.logoutButton.isHidden = true
                self.passwordTextField.isHidden = false
                self.usernameTextField.isHidden = false
                self.statusField.text = "Login"
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
