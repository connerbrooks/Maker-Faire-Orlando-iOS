//
//  EventDetailViewController.swift
//  Maker Faire Orlando
//
//  Created by Conner Brooks on 7/12/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//


import UIKit

class EventDetailViewController : UIViewController {

    @IBOutlet var eventTitle: UILabel!
    
    var event : Event?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.event?.summary)
        eventTitle.text = self.event?.summary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}