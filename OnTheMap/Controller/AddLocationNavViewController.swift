//
//  AddLocationNavViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/5/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class AddLocationNavViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cutomizeTopBar()
    }
   
}

extension AddLocationNavViewController {
    
    func cutomizeTopBar ()
    {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel(_:)))
      
    self.navigationBar.topItem?.leftBarButtonItem = cancelButton
    
    self.navigationBar.topItem?.title = "Add Location"
    }

    
    @objc private func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
