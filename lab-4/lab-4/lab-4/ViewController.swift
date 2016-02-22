/*
 * @author                  Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course                  ASU CSE 394
 * @project                 Lab 4
 * @version                 February 22, 2016
 * @project description     Keeps track of data using Core Data
 * @class name              ViewController.swift
 * @class description       Handles interactions between the view and the user.
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

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var nameNew: UITextField!
    @IBOutlet weak var descNew: UITextView!
    @IBOutlet weak var placeNumberShown: UILabel!
    @IBOutlet weak var nameShown: UITextField!
    @IBOutlet weak var descShown: UITextView!
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var selectedIndex:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fetch().count > 0 {
            selectedIndex = 0
        }
        update()
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Locations")
        return fetchRequest
    }
    
    func fetch() -> [Locations] {
        var result:[Locations] = []
        do {
            result = try context.executeFetchRequest(listFetchRequest()) as! [Locations]
        } catch {
            result = []
        }
        return result
    }

    @IBAction func addNew(sender: UIButton) {
        let context = self.context
        let ent = NSEntityDescription.entityForName("Locations", inManagedObjectContext: context)
        
        let newLocation = Locations(entity: ent!, insertIntoManagedObjectContext: context)
        newLocation.loc_name = nameNew.text
        newLocation.loc_description = descNew.text
        
        nameNew.text = ""
        descNew.text = ""
        
        do {
            try context.save()
            if selectedIndex == fetch().count - 2 {
                selectedIndex += 1
            }
        } catch _ {
            print("Error commiting changes")
        }
        update()
    }

    @IBAction func deleteShown(sender: UIButton) {
        var entries:[Locations] = fetch()
        if selectedIndex >= 0 && selectedIndex < entries.count {
            let entryToDelete = entries[selectedIndex] as NSManagedObject
            context.deleteObject(entryToDelete)
            do {
                try context.save()
                if selectedIndex == fetch().count {
                    selectedIndex -= 1
                }
            } catch _ {
                NSLog("Error deleting entry.")
            }
            update()
        }
        else {
            NSLog("Cannot delete Index: \(selectedIndex) (Empty List)")
        }
    }
    
    @IBAction func previousButton(sender: UIButton) {
        selectedIndex -= 1
        update()
    }
    @IBAction func nextButton(sender: UIButton) {
        selectedIndex += 1
        update()
    }
    
    func update() {
        var entries:[Locations] = fetch()
        var entry:Locations? = nil
        if entries.count > 0 {
            if selectedIndex >= 0 && selectedIndex < entries.count {
                entry = entries[selectedIndex]
            }
            else if selectedIndex >= entries.count {
                selectedIndex = 0
                entry = entries[selectedIndex]
            }
            else if selectedIndex < entries.count {
                selectedIndex = entries.count - 1
                entry = entries[selectedIndex]
            }
            nameShown.text = entry?.loc_name
            descShown.text = entry?.loc_description
            placeNumberShown.text = "Place \(selectedIndex + 1) / \(entries.count)"
        }
        else {
            selectedIndex = -1
            NSLog("Updated - Empty List")
            nameShown.text = ""
            descShown.text = ""
            placeNumberShown.text = "No Places"
        }
    }
}
