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
        map.delegate=self
 
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
                            
                            let annotation = PinAnnotation(activity: activity!)
                            annotation?.coordinate = CLLocationCoordinate2DMake((activity?.location?.lat!)!, (activity?.location?.lng!)!);
                            annotation?.title = activity?.name
                            
                            
                            self.map.addAnnotation(annotation!)
                            
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
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        annotationView?.canShowCallout = true
        let button = UIButton.init(type: UIButtonType.detailDisclosure)
        annotationView?.rightCalloutAccessoryView = button
        
        
        //button.addTarget(self, action: #selector(self.pinViewTouch(sender:)), for: .touchUpInside)
 
        return annotationView
    }*/
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            
            //performSegue(withIdentifier: "navFromMapToDetail", sender: Any?.self)
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
            let annotation = view.annotation as? PinAnnotation
            
            //let activityDetailsVC = ActivityDetailsViewController()
            let activityDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "activityDetails") as? ActivityDetailsViewController
            activityDetailsVC?.activity = annotation?.activity
            //self.present(activityDetailsVC!, animated: true, completion: nil)
            self.navigationController?.pushViewController(activityDetailsVC!, animated: true)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            let annot = annotation as? PinAnnotation
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        let button = UIButton(type: .detailDisclosure) as UIButton // button with info sign in it
        
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func pinViewTouch(sender: UIButton?) {
        performSegue(withIdentifier: "navFromMapToDetail", sender: Any?.self)
        
    }
 */
    
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

