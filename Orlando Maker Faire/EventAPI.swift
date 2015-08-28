//
//  CalendarAPI.swift
//  Maker Faire Orlando
//
//  Created by Conner Brooks on 6/12/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import Foundation

protocol EventAPIProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class EventAPI {
    
    // Your API key here
    let eventAPIKey: String = "AIzaSyApmGbYssXVQ0_BM-UyC7UiVvfO6AS9soo"
    
    var delegate: EventAPIProtocol?
    
    init(delegate: EventAPIProtocol?) {
        self.delegate = delegate
    }
    
    func getEvents() {
        // let urlPath = "https://www.googleapis.com/calendar/v3/calendars/orlandominimakerfaire.com_vffhp2b6oi3kiu3trnoo1502hg@group.calendar.google.com/events?key="
        let urlPath = "http://www.makerfaireorlando.com/events-json"
        // let url: NSURL? = NSURL(string: urlPath + eventAPIKey)
        let url: NSURL? = NSURL(string: urlPath)
        let request: NSURLRequest = NSURLRequest(URL: url!)

        // NSURLConnection.sendAsynchronousRequest(<#request: NSURLRequest#>, queue: <#NSOperationQueue!#>, completionHandler: <#(NSURLResponse!, NSData!, NSError!) -> Void##(NSURLResponse!, NSData!, NSError!) -> Void#>)


        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            if error != nil {
                println("ERROR: \(error.localizedDescription)")
            }
            else {
                var error: NSError?
                let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers | NSJSONReadingOptions.AllowFragments, error: &error) as! NSDictionary
                // Now send the JSON result to our delegate object
                if error != nil {
                    println("HTTP Error: \(error?.localizedDescription)")
                }
                else {
                    println("Results recieved")
                    self.delegate?.didReceiveAPIResults(jsonResult)
                }
            }
            })
    }
}

//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//            if error != nil {
//                println("ERROR: \(error.localizedDescription)")
//            }
//            else {
////                var error: NSError?
////                let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers | NSJSONReadingOptions.AllowFragments, error: &error) as! NSDictionary
////                // Now send the JSON result to our delegate object
////                if error != nil {
////                    println("HTTP Error: \(error?.localizedDescription)")
////                }
////                else {
////                    println("Results recieved")
////                    self.delegate?.didReceiveAPIResults(jsonResult)
////                }
//
//                if let d = data {
//                    var datastring = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
//                    println("datastring: \(datastring)")
//                }
//                var jsonError: NSError?
//                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as? [String: AnyObject] // ,
//                if let e = jsonError {
//                    println("jsonError: \(e)")
//                    
//                }
//            }
//        })

