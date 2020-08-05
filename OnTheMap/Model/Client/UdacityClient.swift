//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Amnah on 7/23/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class UdacityClient {
    
    enum EndPoints: String {
        
        case sessionRequest = "https://onthemap-api.udacity.com/v1/session"
        case studentLocationsRequest = "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100&order=-updatedAt"
        
        // Copmuted value to convert string to URL
        var url: URL{
        return URL(string: self.rawValue)!
        }
    }
    
}

// Helper method
extension UdacityClient {
    
    // Subset first 5 charachters of response data
    class func subsetResponseData (data: Data) -> Data {
        let range = 5..<data.count
        let newData = data.subdata(in: range) /* subset response data! */
        print(String(data: newData, encoding: .utf8)!)
        return newData
    }
    
}
