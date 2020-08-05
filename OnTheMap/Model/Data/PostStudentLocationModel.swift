//
//  PostStudentLocationModel.swift
//  OnTheMap
//
//  Created by Amnah on 8/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class PostStudentLocationModel {
    
    static let shared = PostStudentLocationModel()
    
    private init(){}
    
    var userLocationID = PostStudentLocationData(createdAt: nil, objectId: nil)
}

