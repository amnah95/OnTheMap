//
//  PostStudentLocation.swift
//  OnTheMap
//
//  Created by Amnah on 8/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class PostStudentLocation {
    
    static let shared = PostStudentLocation()
    
    
    class func postNewStudentLocation (userInfromation: AddStudentLocationData, completionHandler: @escaping (PostStudentLocationData?, String?) -> Void)
    {
        var request = URLRequest(url: UdacityClient.EndPoints.studentLocationsRequest.url)
        // POST method to send infromation to the server
       request.httpMethod = "POST"
        // Inform server of format type is expected for recieved data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(userInfromation.uniqueKey)\", \"firstName\": \"\(userInfromation.firstName)\", \"lastName\": \"\(userInfromation.lastName)\", \"mapString\": \"\(userInfromation.mapString!))\", \"mediaURL\": \"\( userInfromation.mediaURL!)\", \"latitude\": \(String(userInfromation.latitude)), \"longitude\": \(String(userInfromation.longitude))}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
        
            // continue if error is nil
            guard error == nil else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
          
            //  continue if data is not nil
            guard data == data else {
                completionHandler(nil, "No data is avalible")
                return
            }
            
            // continure if response is successful
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                    // decode them to get error message passed on
                    let decodedData = try! JSONDecoder().decode(ErrorData.self, from: UdacityClient.subsetResponseData(data: data!))
                    completionHandler(nil, decodedData.error)
                return
            }
            
            // Decode response data recieved
            let decoder = JSONDecoder()
            do {
                let responseResults = try decoder.decode(PostStudentLocationData.self, from: data!)
                completionHandler(responseResults, nil)
                print(String(data: data!, encoding: .utf8)!)
            } catch {
                
                completionHandler(nil, "Could not retrieve data properly")
            }
        }
        task.resume()
    }
    
}
