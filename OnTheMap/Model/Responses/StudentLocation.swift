//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Amnah on 8/3/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct StudentInformation: Codable, Equatable {
    
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}

struct PostStudentLocationData: Codable {
    let createdAt: String?
    let objectId: String?
    
}


