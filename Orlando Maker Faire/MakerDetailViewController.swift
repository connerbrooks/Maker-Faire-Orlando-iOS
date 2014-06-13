//
//  MakerDetailViewController.swift
//  Maker Faire Orlando
//
//  Created by Conner Brooks on 6/10/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import UIKit


class MakerDetailViewController : UIViewController {
    
    @IBOutlet var makerTitle : UILabel
    @IBOutlet var makerWebSite : UILabel
    @IBOutlet var makerOranization : UILabel
    @IBOutlet var makerDescription : UITextView
    
    var maker:Maker?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController.title = "whattheheh"
        
        makerTitle.text = self.maker?.project_name
        makerDescription.text = self.maker?.maker_description
        makerWebSite.text = self.maker?.web_site
        makerOranization.text = self.maker?.organization
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}