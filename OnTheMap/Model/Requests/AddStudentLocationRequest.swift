//
//  AddStudentLocationRequest.swift
//  OnTheMap
//
//  Created by Amnah on 8/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct AddStudentLocationData {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String?
    var mediaURL: String?
    var latitude: Double
    var longitude: Double
}
