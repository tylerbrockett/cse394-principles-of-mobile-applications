/*
 * @author              Tyler Brockett	mailto:tylerbrockett@gmail.com
 * @course              ASU CSE 394
 * @project             Lab 5
 * @version             February 29, 2016
 * @project-description Use MapKit to plot places of interest.
 * @class-name          DetailViewController.swift
 * @class-description   Shows the map of the selected location, and annotates that location. Has the ability to switch between normal view and satellite view.
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

class MapViewController: UIViewController {

    var location:Location? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapMode: UISegmentedControl!
    
    @IBAction func mapModeAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = MKMapType.Hybrid
        }
        else if sender.selectedSegmentIndex == 1 {
            mapView.mapType = MKMapType.Standard
        }
        else if sender.selectedSegmentIndex == 2 {
            mapView.mapType = MKMapType.Satellite
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = location!.name
        let geocoder = CLGeocoder()
        let address = self.location!.name

        geocoder.geocodeAddressString (address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if placemarks != nil && placemarks!.count > 0 {
                let placemark:CLPlacemark = placemarks![0]
                let latitude = placemark.location!.coordinate.latitude
                let longitude = placemark.location!.coordinate.longitude
                
                self.coordinatesLabel.text = "(\(String.localizedStringWithFormat("%.3f", latitude)), \(String.localizedStringWithFormat("%.3f", longitude)))"
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            }
            else {
                self.coordinatesLabel.text = "Invalid location"
            }
                        
            /* add an annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = location.name

            self.mapView.addAnnotation(annotation)
            */
            //self.map.setRegion(region, animated: true)
            //self.map.addAnnotation(MKPlacemark(placemark: placemark))
        })
    }
}
