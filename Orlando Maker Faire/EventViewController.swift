//
//  SecondViewController.swift
//  Orlando Maker Faire
//
//  Created by Conner Brooks on 6/8/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EventAPIProtocol {
    
    let kCellIdentifier: String = "EventCell"
    
    var api: EventAPI?
    
    @IBOutlet var eventTableView : UITableView!
    
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.api = EventAPI(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.api?.getEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        let event = self.events[indexPath.row]
        cell.textLabel!.text = event.summary
        cell.detailTextLabel!.text = event.location
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var detailViewController: EventDetailViewController = segue.destinationViewController as! EventDetailViewController
        var eventIndex = eventTableView.indexPathForSelectedRow()!.row
        var selectedEvent = self.events[eventIndex]
        detailViewController.event = selectedEvent
        
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        let days: NSArray = results["days"] as! NSArray
        let day: NSDictionary = days[0] as! NSDictionary
        let date_title = day["date_title"] as! NSString
        println("date_title = \(date_title)")
        let events: [NSDictionary] = day["events"] as! [NSDictionary]
        for e in events {
            let name = e["name"] as! NSString
            println("name = \(name)")
            var event_description: String? = e["name"] as? String
            var summary: String? = e["description"] as? String
            var location: String? = e["location"] as? String
            var link: String? = e["promo_url"] as? String

            var startString : String = "1/1/90" // startDict["dateTime"] as! String
            var endString : String = "1/2/91" // endDict["dateTime"] as! String

            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'-'HH':'mm'"

            var start: NSDate = NSDate.new()
            var end: NSDate = NSDate.new()
            
            var newEvent = Event(summary: summary, event_description: event_description, location: location, link: link, start: start, end: end)
            
            self.events.append(newEvent)
        }
        
//        let allResults: [NSDictionary] = results["items"] as! [NSDictionary]
//        for result:NSDictionary in allResults {
//            
//            var location: String? = result["location"] as? String
//            var link: String? = result["htmllink"] as? String
//            var event_description: String? = result["description"] as? String
//            var summary: String? = result["summary"] as? String
//            
//            
//            var formatter: NSDateFormatter = NSDateFormatter()
//            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'-'HH':'mm'"
//            var startDict : NSDictionary = result["start"] as! NSDictionary
//            var endDict : NSDictionary = result["end"] as! NSDictionary
//            
//            var startString : String = startDict["dateTime"] as! String
//            var endString : String = endDict["dateTime"] as! String
//            
//            println(startString)
//            
//            var start: NSDate = formatter.dateFromString(startString)!
//            var end: NSDate = formatter.dateFromString(endString)!
//            println(start)
//            
//            
//            var newEvent = Event(summary: summary, event_description: event_description, location: location, link: link, start: start, end: end)
//            
//            self.events.append(newEvent)
//        }
//       
        self.eventTableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }


}

