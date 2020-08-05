//
//  Login.swift
//  OnTheMap
//
//  Created by Amnah on 7/22/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit


class Login {
    
    // Make it sharable across all calsses
    static let shared = Login()
        
    // Request API to authenticate user, return authenticate staus and error mesage if any
    class func requestLoginSession(userEntery: AuthenticationData, completionHandler: @escaping (Bool, String?) -> Void ) {

        var request = URLRequest(url: UdacityClient.EndPoints.sessionRequest.url)
        // POST method to send infromation to the server
        request.httpMethod = "POST"
        // Inform server of responses type accpted by client
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // Inform server of format type is expected for recieved data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string and the user entry
        request.httpBody = "{\"udacity\": {\"username\": \"\(userEntery.email)\", \"password\": \"\(userEntery.password)\"}}".data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in

            // continue if error is nil
            guard error == nil else {
                completionHandler(false, error?.localizedDescription)
            return
            }
            
            //  continue if data is not nil
            guard data == data else {
                completionHandler(false, "No data is avalible")
                return
            }
            
            // continure if response is successful, but worng credintials
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                    // decode them to get error message passed on
                    let decodedData = try! JSONDecoder().decode(ErrorData.self, from: UdacityClient.subsetResponseData(data: data!))
                    completionHandler(false, decodedData.error)
                return
            }
            
            // Code to excute if login succeed
            completionHandler(true, nil)

        }
        task.resume()
    }

}
