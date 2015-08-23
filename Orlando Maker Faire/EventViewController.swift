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
    
    func didReceiveAPIResults(results: [String : [[String : AnyObject]]]) {
        let allResults: [[String : AnyObject]] = results["items"]!
        for result in allResults {
            
            var location = result["location"] as! String
            var link = result["htmllink"] as! String
            var event_description = result["description"] as! String
            var summary = result["summary"] as! String
            
            
            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'-'HH':'mm'"
            var startDict = result["start"] as! [String : String]
            var endDict = result["end"] as! [String : String]
            
            var startString = startDict["dateTime"] as String!
            var endString = endDict["dateTime"] as String!
            
            println(startString)
            
            var start: NSDate = formatter.dateFromString(startString)!
            var end: NSDate = formatter.dateFromString(endString)!
            println(start)
            
            
            var newEvent = Event(summary: summary, event_description: event_description, location: location, link: link, start: start, end: end)
            
            self.events.append(newEvent)
        }
       
        self.eventTableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

