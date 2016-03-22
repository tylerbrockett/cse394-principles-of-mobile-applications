/*
 * @author				Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course				ASU CSE 394
 * @project             Lab 6
 * @version             March 21, 2016
 * @project-description Collects data from www.geonames.org and presents it to the user.
 * @class-name          TableViewController.swift
 * @class-description   Displays basic earthquake data about location to user.
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

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func segmentedAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sort(0)
        }
        else if sender.selectedSegmentIndex == 1 {
            sort(1)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var location:String = ""
    var coordinates:String = ""
    var earthquakes:NSArray = NSArray()
    
    @IBOutlet weak var locationTF: UILabel!
    @IBOutlet weak var coordinatesTF: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("SIZE: \(earthquakes.count)")
        tableView?.delegate = self
        tableView?.dataSource = self
        locationTF.text = location
        coordinatesTF.text = coordinates
    }
    
    func sort(mode:Int) {
        switch mode {
            case 0:
                NSLog("Sort by MAGNITUDE")
                earthquakes = earthquakes.sort{
                    item1, item2 in
                    let date1 = (item1 as! NSDictionary).valueForKey("magnitude") as! Double
                    let date2 = (item2 as! NSDictionary).valueForKey("magnitude") as! Double
                    return date1 > date2
                }
                break
            case 1:
                NSLog("Sort by DATETIME")
                earthquakes = earthquakes.sort{
                    item1, item2 in
                    let date1 = (item1 as! NSDictionary).valueForKey("datetime") as! String
                    let date2 = (item2 as! NSDictionary).valueForKey("datetime") as! String
                    return date1 > date2
                }
                break
            default:
                NSLog("Sort mode invalid")
                break
        }
        tableView?.reloadData()
    }
    
    // TableView functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakes.count
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let earthquake:NSDictionary = earthquakes[indexPath.row] as! NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        cell.textLabel?.text = ("Magnitude: \(earthquake.valueForKey("magnitude") as! Double)")
        cell.detailTextLabel?.text = ("Time: \(earthquake.valueForKey("datetime") as! String)")
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "details"){
            if let viewController: DetailViewController = segue.destinationViewController as? DetailViewController {
                let cell = sender as! UITableViewCell
                let indexPath = self.tableView.indexPathForCell(cell)
                viewController.location = self.location
                viewController.coordinates = self.coordinates
                viewController.dictionary = earthquakes[indexPath!.row] as! NSDictionary
            }
            else {
                NSLog("\n\n\nERROR!!!\n\n\n")
            }
        }
    }
}
