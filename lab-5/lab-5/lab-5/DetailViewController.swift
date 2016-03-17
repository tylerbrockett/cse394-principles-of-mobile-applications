/*
* @author              Tyler Brockett	mailto:tylerbrockett@gmail.com
* @course              ASU CSE 394
* @project             Lab 5
* @version             February 29, 2016
* @project-description Use MapKit to plot places of interest.
* @class-name          DetailViewController.swift
* @class-description   Allows user to create a new Location object and insert into core data.
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
import Foundation
import CoreData

class DetailViewController: UIViewController {
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBAction func saveLocation(sender: UIBarButtonItem) {
        if nameTF.text == "" {
            NSLog("Error: Not all info was filled out or selected.")
            return
        }
        let ent = NSEntityDescription.entityForName("Location", inManagedObjectContext: self.context)
        let location:Location = Location(entity: ent!, insertIntoManagedObjectContext: self.context)
        location.name = nameTF.text
        do {
            try self.context.save()
        } catch _ {
            NSLog("Error saving data")
        }
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
