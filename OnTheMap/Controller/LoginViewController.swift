//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Amnah on 7/5/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit


class LoginViewController: UIViewController  {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextAttribute([emailField,passwordField])
        self.setClickableLabelAttribute(signUpLabel)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Subscribe to keyboared notification
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unubscribe from keyboared notification
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // login button tapped
    @IBAction func loginTapped(_ sender: Any) {
        
        //First check fields are not nil/empty, else show alert
        guard let enteredEmail = emailField.text,
            enteredEmail != "",
            let enteredPassword = passwordField.text,
            enteredPassword != ""
            else
        {
                errorAlert(errorMessage: "Please enter your email and password.")
                return
        }
        
        // Call login request sesstions
        Login.requestLoginSession(
        userEntery: AuthenticationData.init(
            email: enteredEmail,
            password: enteredPassword
        )) { (loginStatus, errorMessage) in
            
            // Guared to check if there is any error
            guard loginStatus == true else {
                self.errorAlert(errorMessage: errorMessage!)
                return
            }
            self.persentMainViewController()
        }
    }
    
    // Move to main view
    func persentMainViewController() {
        DispatchQueue.main.async {
            let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UITabBarController
            mainViewController.modalPresentationStyle = .fullScreen
            self.show(mainViewController, sender: nil)
        }
    }
}


// Extension for text field delegates
extension LoginViewController: UITextFieldDelegate {
    
    // Implementing attributes function
    func setTextAttribute(_ textFields : [UITextField]) {
        for textField in textFields {
            textField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}

// Extention for clickble link
extension LoginViewController {
    
    // Implementing attributes function
    func setClickableLabelAttribute(_ label : UILabel) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.signUpTapped(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
    }
    
    @objc func signUpTapped(sender:UITapGestureRecognizer) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }
}

// Extentions for keyboard notifications subscribe/unsubscribe methods
private extension LoginViewController {
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {

        if view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {

        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}


// Alret
extension LoginViewController {
    
    // Alret Controller function
    func errorAlert (errorMessage: String)
    {
        DispatchQueue.main.async {
            let credentialsAlertController = UIAlertController(
                title: "Error",
                message: errorMessage,
                preferredStyle: .alert
            )
            credentialsAlertController.addAction(UIAlertAction(
                title: "Dismiss",
                style:UIAlertAction.Style.default
            ))
            self.present(credentialsAlertController, animated: true, completion: nil)
        }
    }
}


