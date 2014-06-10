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
    
        cell.text = rowData["project_name"] as String
        cell.detailTextLabel.text = rowData["organization"] as String
        
        /* images when json is properly formed
        var urlString: NSString = rowData["photo_link"] as NSString
        var imgURL: NSURL = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        */
        
        return cell
    }
    
    func getMakers() {
        var urlPath = "http://callformakers.org/orlando2014/default/overview.json/raw"
        var url : NSURL = NSURL(string: urlPath)
        var request :NSURLRequest =  NSURLRequest(URL: url)
        var connection : NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
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
    }
    
    
}
