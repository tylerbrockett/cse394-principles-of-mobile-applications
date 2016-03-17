/*
 * @author              Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course              ASU CSE 394
 * @project             Lab 5
 * @version             February 29, 2016
 * @project-description Use MapKit to plot places of interest.
 * @class-name          TableViewController.swift
 * @class-description   Handles displaying the list of Location objects. User can click on location to view details about the location.
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Tyler Brockett
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var locationsTV: UITableView!
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // Setting up Core Data stuff
        dataViewController = getFetchResultsController()
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Location")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    
    // NSFetchedResultsController is kind of the middle man between core data and table view
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.locationsTV.reloadData()
    }
    
    @IBAction func newEntry(sender: UIBarButtonItem) {
        performSegueWithIdentifier("new", sender: self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections  = dataViewController.sections?.count
        return numberOfSections!
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = dataViewController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = locationsTV.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath)
        let location = dataViewController.objectAtIndexPath(indexPath) as! Location
        cell.textLabel?.text = location.name
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "map" {
            let cell = sender as! UITableViewCell
            let indexPath = self.locationsTV.indexPathForCell(cell)
            let dest: MapViewController = segue.destinationViewController as! MapViewController
            let row = dataViewController.objectAtIndexPath(indexPath!) as! Location
            dest.location = row
        }
        /*
        else if segue.identifier == "new" {
            let dest: DetailViewController = segue.destinationViewController as! DetailViewController
            // Nothing needs to be done here.
        }
        */
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let location = dataViewController.objectAtIndexPath(indexPath) as! Location
            context.deleteObject(location)
            do {
                try context.save()
            } catch _ {
                NSLog("Error deleting element.")
            }
        }
    }
}
