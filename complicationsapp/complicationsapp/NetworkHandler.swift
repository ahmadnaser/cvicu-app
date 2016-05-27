//
//  NetworkHandler.swift
//  complicationsapp
//
//  Created by Ken Chen on 5/27/16.
//  Copyright © 2016 cvicu. All rights reserved.
//

import Foundation

class NetworkHandler {
    let myURL : NSURL
    let postString : String
    
    init(url: String, postString: String) {
        myURL = NSURL(string: url)!
        self.postString = postString
    }
    
    func postToServer() {
        let request = NSMutableURLRequest(URL: myURL)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Check for fundamental networking error
            guard error == nil && data != nil else {
                print("error = \(error)")
                return
            }
            
            // Check for http errors
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}