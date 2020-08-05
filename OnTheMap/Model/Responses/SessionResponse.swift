//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Amnah on 8/3/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation


struct SessionData: Codable {
    let id: String
    let expiration: String
}

struct AccountData: Codable {
    let registered: Bool
    let key: String
}

// Data recieved when network fails
struct ErrorData: Codable {
    let status: Int
    let error: String
}
