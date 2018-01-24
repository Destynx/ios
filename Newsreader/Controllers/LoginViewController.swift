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
        username = usernameInput.text
        password = passwordInput.text
        
        webservice.executeLogin(username : username, password : password, withSuccess: { (succes) in
            if(succes == true){
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
                let message = UIAlertController(title: "Failure", message: "Username or Password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
                message.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                DispatchQueue.main.async {
                    self.present(message, animated: true, completion: nil)
                }
            }
        }, orFailure: { (error) in
            let message = UIAlertController(title: "Failure", message: "Username or Password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
            message.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            DispatchQueue.main.async {
                self.present(message, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        webservice.loguout()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
