//
//  LoginViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-03-11.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let username = "Colleen"
    private let password = "cooleen"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            // Nothing in username and password
            let loginAlert = UIAlertController(title: "Login Unsuccessful", message: "Please enter your username and password", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            loginAlert.addAction(okAction)
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
        } else if usernameTextField.text == username && passwordTextField.text == password {
            // username and password match
            let SMNavController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("SMNavController") as SMNavigationController
            
            self.presentViewController(SMNavController, animated: true, completion: nil)
            
        } else {
            let loginAlert = UIAlertController(title: "Login Unsuccessful", message: "Username and password do not match", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            loginAlert.addAction(okAction)
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: UITextField Delegate Methods

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    // If user touches outside the keyboard, resign keyboard
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
