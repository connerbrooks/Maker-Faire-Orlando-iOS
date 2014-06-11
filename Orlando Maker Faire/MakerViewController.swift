//
//  MakerViewController.swift
//  Orlando Maker Faire
//
//  Created by Conner Brooks on 6/9/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate {
    
    @IBOutlet var makerTableView : UITableView = nil
    
    var makerData: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    
    var makers: Maker[] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getMakers() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MakerCell")
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        println(rowData)
    
        cell.text = rowData["project_name"] as String
        cell.detailTextLabel.text = rowData["organization"] as String
        
        // Should format these to fit
        /*
        if rowData["photo_link"] != nil {
            var urlString: NSString = rowData["photo_link"] as NSString
            var imgURL: NSURL = NSURL(string: urlString)
        
            // Download an NSData representation of the image at the URL
            var imgData: NSData = NSData(contentsOfURL: imgURL)
            cell.image = UIImage(data: imgData)
        }
        */

        
        return cell
    }
    
    func getMakers() {
        var urlPath = "http://callformakers.org/orlando2014/default/overviewALL.json/raw"
        var url : NSURL = NSURL(string: urlPath)
        var request :NSURLRequest =  NSURLRequest(URL: url)
        var connection : NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    
    // Connection delegate methods
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.makerData = NSMutableData() // for now, need to move to core data
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.makerData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(makerData, options:    NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        if jsonResult.count > 0 && jsonResult["accepteds"].count > 0 {
        
            var results: NSArray = jsonResult["accepteds"] as NSArray
            self.tableData = results
            self.makerTableView.reloadData()
        }

        
        let allResults: NSDictionary[] = jsonResult["accepteds"] as NSDictionary[]

        /*
        for result:NSDictionary in allResults {
            
            var category: String? = result["category"] as? String
            var project_name: String? = result["project_name"] as? String
            var description: String? = result["description"] as? String
            var web_site: String? = result["web_site"] as? String
            var promo_url: String? = result["promo_url"] as? String
            var qrcode_url: String? = result["qrcode_url"] as? String
            var project_short_summary: String? = result["project_short_summary"] as? String
            var location: String? = result["location"] as? String
            var organization: String? = result["organization"] as? String
            var photo_link: String? = result["photo_link"] as? String
            
            var newMaker = Maker(category: category, project_name: project_name, description: description, web_site: web_site, promo_url: promo_url, qrcode_url: qrcode_url, project_short_summary: project_short_summary, location: location, organization: organization, photo_link: photo_link)
            
            println(newMaker)
            self.makers.append(newMaker)
        }
        */
    }
    
    
}
