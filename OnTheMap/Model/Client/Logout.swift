//
//  Logout.swift
//  OnTheMap
//
//  Created by Amnah on 8/3/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class Logout {
    
    static let shared = Logout()
    
    class func requestLogoutSession (completionHandler: @escaping (Bool, String?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in

            // continue if error is nil
            guard error == nil else {
                completionHandler(false, error?.localizedDescription)
                return
            }
                
            //  continue if data is not nil
            guard data == data else {
                completionHandler(false, "No data is Avalible")
                return
            }
                
            // continure if response is successful, but worng credintials
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
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
