//
//  BaseNavController.swift
//  OnTheMap
//
//  Created by Amnah on 8/1/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class BaseNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cutomizeTopBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension BaseNavController {
    // Adding bar buttons to the controller
    func cutomizeTopBar ()
    {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocation(_:)))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshData(_:)))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logout(_:)))
        self.navigationBar.topItem?.rightBarButtonItems = [addButton, refreshButton]
        self.navigationBar.topItem?.leftBarButtonItem = logoutButton
        self.navigationBar.topItem?.title = "On The Map"
    }

    // Buttons functions
    @objc private func addLocation(_ sender: Any)
    {
        let addLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationNavViewController") as! UINavigationController
        addLocationViewController.modalPresentationStyle = .fullScreen
        self.present(addLocationViewController, animated: true, completion: nil)
    }

    @objc private func refreshData(_ sender: Any)
    {
        GetStudentLocation.getAllStudentsLocations(completionHandler: { (responseResults, errorMessage) in
        guard let responseResults = responseResults else {return}
        StudentsInfromationModel.shared.results = responseResults
        }
            
    )
        
    }

    @objc private func logout(_ sender: Any)
    {
        // Call login request sesstions
        Logout.requestLogoutSession(completionHandler: { (logoutStatus, errorMessage) in
            
            // Guared to check if there is any error
            guard logoutStatus == true else {
                self.errorAlert(errorMessage: errorMessage!)
                return
            }
            // If no error, dismiss view
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

extension BaseNavController {
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

