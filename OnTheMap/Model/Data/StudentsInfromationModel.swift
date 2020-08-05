//
//  StudentsInfromationModel.swift
//  OnTheMap
//
//  Created by Amnah on 8/2/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class StudentsInfromationModel {
    
    static let shared = StudentsInfromationModel()
    
    private init(){}
    
    var results = [StudentInformation]()

}

