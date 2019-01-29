//
//  ViewController.swift
//  Location Aware
//
//  Created by Derrick White on 1/10/19.
//  Copyright © 2019 Derrick White. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        self.latitude.text = String(userLocation.coordinate.latitude)
        self.longitude.text = String(userLocation.coordinate.longitude)
        self.course.text = String(userLocation.course)
        self.speed.text = String(userLocation.speed)
        self.altitude.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var subThoroughFare = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        subThoroughFare = placemark.subThoroughfare!
                        
                    }
                    
                    var thoroughFare = ""
                    
                    if placemark.thoroughfare != nil {
                        
                        thoroughFare = placemark.thoroughfare!
                        
                    }
                    
                    var locality = ""
                    
                    if placemark.locality != nil {
                        
                        locality = placemark.locality!
                        
                    }
                    
                    var administrativeArea = ""
                    
                    if placemark.administrativeArea != nil {
                        
                        administrativeArea = placemark.administrativeArea!
                        
                    }
                    
                    var postalCode = ""
                    
                    if placemark.postalCode != nil {
                        
                        postalCode = placemark.postalCode!
                        
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                        
                    }
                    
                    self.address.text = subThoroughFare + " " + thoroughFare + "\n" + locality + ", " + administrativeArea + "\n" + postalCode + "\n" + country
                    
                }
                
            }
            
        }
    }
}
