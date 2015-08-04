//
//  MakerViewController.swift
//  Orlando Maker Faire
//
//  Created by Conner Brooks on 6/9/14.
//  Copyright (c) 2014 Conner Brooks. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MakerAPIProtocol, UISearchBarDelegate {

    let kCellIdentifier: String = "MakerCell"
    
    var api: MakerAPI?
    
    @IBOutlet var makerTableView : UITableView!
    
    var makers: [Maker] = []
    
    var searchResults: [Maker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.api = MakerAPI(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.api!.getMakers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
    
        
        let maker = self.makers[indexPath.row]
        cell.textLabel!.text = maker.project_name
        cell.detailTextLabel!.text = maker.organization
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var detailViewController: MakerDetailViewController = segue.destinationViewController as! MakerDetailViewController
        var makerIndex = makerTableView.indexPathForSelectedRow()!.row
        var selectedMaker = self.makers[makerIndex]
        detailViewController.maker = selectedMaker
        
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        
        let allResults: [NSDictionary] = results["accepteds"] as! [NSDictionary]
    
        for result:NSDictionary in allResults {
            var project_name: String? = result["project_name"] as? String
            var maker_description: String? = result["description"] as? String
            var web_site: String? = result["web_site"] as? String
            var organization: String? = result["organization"] as? String
            var project_short_summary: String? = result["project_short_summary"] as? String
            
            //var promo_url: String? = result["promo_url"] as? String
            //var qrcode_url: String? = result["qrcode_url"] as? String
            //var location: String? = result["location"] as? String
            //var category: String? = result["category"] as? String
            //var photo_link: String? = result["photo_link"] as? String
            
            var newMaker = Maker(project_name: project_name, maker_description: maker_description, web_site: web_site, organization: organization, project_short_summary: project_short_summary)
            
            self.makers.append(newMaker)
        }
        
        self.makerTableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}