/*
 * @author				Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course				ASU CSE 394
 * @project				Lab 6
 * @version				March 21, 2016
 * @project-description	Collects data from www.geonames.org and presents it to the user.
 * @class-name          DetailViewController.swift
 * @class-description   Displays specific details about single earthquake event to the user.
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

class DetailViewController: UIViewController {
    
    var location:String = ""
    var coordinates:String = ""
    var dictionary:NSDictionary = NSDictionary()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var srcLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationLabel.text! = location
        coordinatesLabel.text! = coordinates
        datetimeLabel.text! = dictionary.valueForKey("datetime") as! String
        magnitudeLabel.text! = "\(dictionary.valueForKey("magnitude") as! Double)"
        latLabel.text! = "\(dictionary.valueForKey("lat") as! Double)"
        lonLabel.text! = "\(dictionary.valueForKey("lng") as! Double)"
        idLabel.text! = dictionary.valueForKey("eqid") as! String
        depthLabel.text! = "\(dictionary.valueForKey("depth") as! Double)"
        srcLabel.text! = dictionary.valueForKey("src") as! String
    }   
}

