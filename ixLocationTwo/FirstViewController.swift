//
//  FirstViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/5/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import Gloss

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         map.showsUserLocation = true
 
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        Alamofire.request("https://ixlocationtwo.firebaseio.com/Activity.json").responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                if let response = JSON as? NSDictionary {
                
                for (_, value) in response {
                    let activity = Activity()
                    
                    if let actDictionary = value as? [String : AnyObject] {
                        activity?.name = actDictionary["name"] as? String
                        activity?.locationName = actDictionary["locationName"] as? String
                        activity?.date = actDictionary["date"] as? String

                        if let geoPointDictionary = actDictionary["location"] as? [String: AnyObject] {
                            let location = GeoPoint()
                            location.lat = geoPointDictionary["lat"] as? Double
                            location.lng = geoPointDictionary["lng"] as? Double
                            activity?.location = location
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2DMake((activity?.location?.lat!)!, (activity?.location?.lng!)!);
                            annotation.title = activity?.name
                            self.map.addAnnotation(annotation)
                        }
                    }
                    
                    self.activities.append(activity!)
                }
                }
            }
        }
        setMapType()

    }
    override func viewDidAppear(_ animated: Bool) {
        setMapType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setMapType() {
        /*
         Different map types
         map.mapType = .hybrid
         map.mapType = .hybridFlyover
         map.mapType = .satellite
         map.mapType = .satelliteFlyover
         map.mapType = .standard
         */
        let mapType = UserDefaults.standard.string(forKey: "mapType")
        
        if mapType != nil {
            
            if mapType == "hybrid" {
                map.mapType = .hybrid
            }
            
            if mapType == "standard" {
                map.mapType = .standard
            }
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        // Get the users location from the array of locations
        let userLocation: CLLocation = locations[0] as CLLocation
        
        // You can call stopUpdatingLocation() to stop listening for location updates
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        // Store reference to the users location in the class instance (self)
        self.currentUserLocation = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        // An error occurred trying to retrieve users location
        print("Error \(error)")
    }
        }
        
 

