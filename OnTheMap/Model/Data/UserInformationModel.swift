//
//  UserInformationModel.swift
//  OnTheMap
//
//  Created by Amnah on 8/5/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class UserInformationModel {
    
    static let shared = UserInformationModel()
    
    private init() {}
    
    var userInformation = AddStudentLocationData.init(
        uniqueKey: "1234",
        firstName: "Amnah",
        lastName: "Samkari",
        mapString: nil,
        mediaURL: nil,
        latitude: 0.00,
        longitude: 0.00)
    
}

