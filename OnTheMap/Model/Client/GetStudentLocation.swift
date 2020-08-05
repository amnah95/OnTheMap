//
//  GetStudentLocation.swift
//  OnTheMap
//
//  Created by Amnah on 8/1/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation


class GetStudentLocation {

    // Make it sharable across all calsses
    static let shared = GetStudentLocation()
    
    // Request 100 results of student infromation and store them
    
    class func getAllStudentsLocations(completionHandler: @escaping ([StudentInformation]?, String?) -> Void) {
     // modify the API request lnik
        let request = URLRequest(url: UdacityClient.EndPoints.studentLocationsRequest.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //  continue if error is not nil
            guard error == nil  else {
                completionHandler(nil, error?.localizedDescription)
            return
            }
            
            //  continue if data is not nil
            guard let data = data else {
                completionHandler(nil, "No data is Avalible")
                return
            }
            
            // Check response
            guard let status = (response as? HTTPURLResponse)?.statusCode, status >= 200 && status <= 399 else {
                  let decodedData = try! JSONDecoder().decode(ErrorData.self, from: data)
                completionHandler(nil, decodedData.error)
                              return
                          }
            // Decode response data recieved
            let decoder = JSONDecoder()
            do {
                let responseResults = try decoder.decode(StudentInformationResults.self, from: data)
                completionHandler(responseResults.results, nil)
            } catch {
                
                completionHandler(nil, "Could not retrive data properly")
            }
        }
        
        task.resume()
    }
}
