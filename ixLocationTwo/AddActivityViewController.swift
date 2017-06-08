//
//  AddActivityViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AddActivityViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!

    
    var delegate: AddActivityDelegate?
    var newActivity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActivity(_ sender: Any) {
        newActivity = Activity()
        newActivity?.name = nameTextField.text!
        newActivity?.locationName = locationTextField.text!
        newActivity?.date = dateTextField.text!
        newActivity?.location = GeoPoint(latitude: currentUserLocation.coordinate.latitude, longitude: currentUserLocation.coordinate.longitude)
        
        Alamofire.request("https://ixlocationtwo.firebaseio.com/Activity.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON{
            response in
        
            switch response.result {
            case .success( _):
                //self.delegate?.didSaveActivity(activity: self.newActivity!)
                self.dismiss(animated: true, completion: nil)
            case .failure: break
            }
        }
        /*
        delegate?.didSaveActivity(activity: newActivity!)
        if (nameTextField.text?.isEmpty)!||(locationTextField.text?.isEmpty)!||(dateTextField.text?.isEmpty)!{
            //throw an error
            print("need to fill both categories")
            
        }
        else{
            dismiss(animated: true, completion: nil)
        }*/
 
    }

    @IBAction func cancelActivity(_ sender: Any) {
        delegate?.didCancelActivity()
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the users location from the array of locations
        let userLocation: CLLocation = locations[0] as CLLocation
        
        // You can call stopUpdatingLocation() to stop listening for location updates
        // manager.stopUpdatingLocation()
        
        // Store reference to the users location in the class instance (self)
        self.currentUserLocation = userLocation
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
