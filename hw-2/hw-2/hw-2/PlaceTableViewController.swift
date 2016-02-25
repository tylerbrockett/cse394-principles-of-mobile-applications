/*
 * @author              Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course              ASU CSE 394
 * @project             Homework 2
 * @version             February 25, 2016
 * @project-description Combines photo handling and database/coredata operations to store places the user has visited.
 * @class-name          PlaceTableViewController.swift
 * @class-description   Handles displaying the Place items to the user in a Table View. Allows for editing/deleting and adding new entries.
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

class PlaceTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var placeTable: UITableView!
    
    @IBAction func newButton(sender: UIBarButtonItem) {
        performSegueWithIdentifier("new", sender: self)
    }
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchResultsController() -> NSFetchedResultsController {
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return dataViewController
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Place")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar stuff
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // Setting up Core Data stuff
        dataViewController = getFetchResultsController()
        dataViewController.delegate = self
        do {
            try dataViewController.performFetch()
        } catch _ {
        }
    }
    
    // NSFetchedResultsController is kind of the middle man between core data and table view
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.placeTable.reloadData()
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
        let cell = placeTable.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomTableViewCell
        let placeInfo = dataViewController.objectAtIndexPath(indexPath) as! Place
        let name = placeInfo.name
        let desc = placeInfo.desc
        let image = UIImage(data: placeInfo.pic! as NSData)
        
        cell.name.text = name
        cell.desc.text = desc
        cell.img.image = image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let place = dataViewController.objectAtIndexPath(indexPath) as! Place
            context.deleteObject(place)
            do {
                try context.save()
            } catch _ {
            }
        }
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.placeTable.indexPathForCell(cell)
            let dest: DetailViewController = segue.destinationViewController as! DetailViewController
            let row = dataViewController.objectAtIndexPath(indexPath!) as! Place
            dest.place = row
        }
        else if segue.identifier == "new" {
            let dest: DetailViewController = segue.destinationViewController as! DetailViewController
            dest.place = nil
        }
    }
}
