//
//  MainViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/2/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestStudentsData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MainViewController {
    // Get latest data method
    func getLatestStudentsData()
    {
        GetStudentLocation.getAllStudentsLocations(completionHandler: { (responseResults, errorMessage) in
            guard let responseResults = responseResults else {
                self.errorAlert(errorMessage: errorMessage!)
                return
            }
            StudentsInfromationModel.shared.results = responseResults
        })
    }
    
}

extension MainViewController {
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


