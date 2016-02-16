//
//  TableViewController.swift
//  lab-4
//
//  Created by Tyler Brockett on 2/16/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let locations:Locations = Locations()
    
    @IBOutlet weak var locationsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        loadList()
    }
    
    func loadList(){
        self.locations.sort()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.getSize()
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        cell.textLabel?.text = locations.get(indexPath.row).getName()
        cell.detailTextLabel?.textAlignment = .Right
        return cell;
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailViewSegue"){
            let selectedIndex: NSIndexPath = self.locationsTV.indexPathForCell(sender as! UITableViewCell)!
            if let detailviewController: DetailViewController = segue.destinationViewController as? DetailViewController {
                detailviewController.location = locations.get(selectedIndex.row)
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            locations.remove(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
