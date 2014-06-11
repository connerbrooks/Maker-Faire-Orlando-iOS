//
//  Maker.swift
//  Maker Faire Orlando
//
//  Created by Conner Brooks on 6/10/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import Foundation

class Maker {
    
    var category:String?
    var project_name:String?
    var description:String?
    var web_site:String?
    var promo_url:String?
    var qrcode_url:String?
    var project_short_summary:String?
    var location:String?
    var organization:String?
    var photo_link:String?
    
    init(category:String!, project_name:String!, description:String!, web_site:String!, promo_url:String!, qrcode_url:String!, project_short_summary:String!, location:String!, organization:String!, photo_link:String! ) {
        
        self.category = category
        self.project_name = project_name
        self.promo_url = promo_url
        self.project_short_summary = project_short_summary
        self.location = location
        self.organization = organization
        self.photo_link = photo_link
    }
}