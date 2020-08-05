//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextAttribute([locationField,linkField])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            subscribeToKeyboardNotifications()       }
        if UIDevice.current.orientation.isPortrait {
            unsubscribeFromKeyboardNotifications()
        }
    }
    
    @IBAction func findLocation(_ sender: Any) {

        //First check fields are not nil/empty, else show alert
        guard let enteredMapString = locationField.text, enteredMapString != "", let enteredMediaURL = linkField.text, enteredMediaURL != "https://" else {
            self.errorAlert(errorMessage: "Please enter your location and URL")
            return
        }

        // Check if geocode string is valid
        //postStudentLocation(userInformation: enteredUserInformation)
        CLGeocoder().geocodeAddressString(enteredMapString) { (placemark, error) in
            //geocodeAddressString will return an array of locations matching our search, pick first one
            guard let firstPlacemark = placemark?.first?.location else {
                self.errorAlert(errorMessage: error!.localizedDescription)
                return
            }
            
            // if place is found, update user location
            UserInformationModel.shared.userInformation.mapString = enteredMapString
            UserInformationModel.shared.userInformation.mediaURL = enteredMediaURL
            UserInformationModel.shared.userInformation.latitude = firstPlacemark.coordinate.latitude
            UserInformationModel.shared.userInformation.longitude = firstPlacemark.coordinate.longitude
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewLocationViewController")
            print("location found \(UserInformationModel.shared.userInformation.latitude),\( UserInformationModel.shared.userInformation.longitude )")
            self.show(viewController!, sender: nil)
        }
    }
}


// Extension for text field delegates
extension AddLocationViewController: UITextFieldDelegate {
    
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


// Extentions for keyboard notifications subscribe/unsubscribe methods
private extension AddLocationViewController {
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if  view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)/1.5 }
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

extension AddLocationViewController {
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
