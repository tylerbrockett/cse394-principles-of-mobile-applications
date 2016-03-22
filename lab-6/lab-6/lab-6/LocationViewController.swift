/*
 * @author				Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course				ASU CSE 394
 * @project				Lab 6
 * @version				March 21, 2016
 * @project-description	Collects data from www.geonames.org and presents it to the user.
 * @class-name          LocationViewController.swift
 * @class-description   Allows user to input location to get data for.
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

import MapKit
import UIKit

class LocationViewController: UIViewController {
    
    var location:String = ""
    var coordinates:String = ""
    
    var result:NSArray = NSArray()
    
    let dist:Double = 1.0
    
    @IBOutlet weak var messageTF: UILabel!
    @IBOutlet weak var locationTF: UITextField!
    
    
    @IBAction func setLoc(sender: UIButton) {
        self.messageTF.text! = "Finding Coordinates"
        self.messageTF.textColor = UIColor.greenColor()
        
        self.location = locationTF.text!
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTF.text!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if placemarks != nil && placemarks!.count > 0 {
                let placemark:CLPlacemark = placemarks![0]
                let latitude = placemark.location!.coordinate.latitude
                let longitude = placemark.location!.coordinate.longitude
                self.coordinates = "(\(String.localizedStringWithFormat("%.2f", latitude)) \(Character(UnicodeScalar(177))) \(String.localizedStringWithFormat("%.0f",self.dist)), \(String.localizedStringWithFormat("%.2f", longitude)) \(Character(UnicodeScalar(177))) \(String.localizedStringWithFormat("%.0f",self.dist)))"
                
                self.messageTF.text! = "Found Coordinates"
                self.messageTF.textColor = UIColor.greenColor()
                NSLog("Found Coordinates: (\(latitude), \(longitude))")
                
                let queryURL:String = Constants.baseURL + "/earthquakesJSON?north=\(latitude + self.dist)&south=\(latitude - self.dist)&east=\(longitude + self.dist)&west=\(latitude - self.dist)&username=tylerbrockett"
                NSLog("Query: \(queryURL)")

                self.messageTF.text! = "Getting data from server"
                self.messageTF.textColor = UIColor.greenColor()
                
                let aConnect:NetworkAsyncTask = NetworkAsyncTask()
                let _ :Bool = aConnect.getEarthquakes(queryURL, callback: {(result: String, error: String?) -> Void in
                    if error != nil {
                        self.result = NSArray()
                        self.messageTF.text! = "Invalid response from server"
                        self.messageTF.textColor = UIColor.redColor()
                        NSLog("Invalid response from server")
                    } else {
                        NSLog("RESPONSE: \(result)")
                        if let data: NSData = result.dataUsingEncoding(NSUTF8StringEncoding){
                            do{
                                let dictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                                self.result = dictionary.valueForKey("earthquakes") as! NSArray
                                NSLog("FINAL ARRAY: \(self.result)")
                                self.messageTF.text! = ""
                                NSLog("Success!")
                                self.performSegueWithIdentifier("list", sender: nil)
                            } catch {
                                NSLog("Unable to convert to array")
                                self.messageTF.text! = "Unable to convert to array."
                                self.messageTF.textColor = UIColor.redColor()
                            }
                        } else {
                            self.messageTF.text! = "Failed to convert result to Array"
                            self.messageTF.textColor = UIColor.redColor()
                        }
                    }
                })
            }
            else {
                self.messageTF.text! = "Invalid Location"
                self.messageTF.textColor = UIColor.redColor()
            }
        })
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "list"){
            if let viewController: TableViewController = segue.destinationViewController as? TableViewController {
                viewController.earthquakes = self.result
                viewController.location = self.location
                viewController.coordinates = self.coordinates
            }
            else {
                NSLog("\n\n\nERROR!!!\n\n\n")
            }
        }
    }
}

