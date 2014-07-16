//
//  File.swift
//  Maker Faire Orlando
//
//  Created by Conner Brooks on 6/12/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import Foundation

class Event {
    var summary:String?
    var event_description:String?
    var location:String?
    var link:String?
    var start:NSDate?
    var end:NSDate?
    
    
    init(summary:String?, event_description:String?, location:String?, link:String?, start:NSDate?, end:NSDate?) {
        self.summary = summary
        self.event_description = event_description
        self.location = location
        self.link = link
        self.start = start
        self.end = end
    }
}