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
import Realm

class AddActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{

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
        //using realm
        
        let act = Activity()
        act.name = nameTextField.text!
        act.locationName = locationTextField.text!
        act.date = dateTextField.text!
        act.location = GeoPoint()
        act.location?.lat = currentUserLocation.coordinate.latitude
        act.location?.lng = currentUserLocation.coordinate.longitude
        
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.add(act)
        
        do {
            try realm.commitWriteTransactionWithoutNotifying([])
        } catch {
            print ("Error")
        }
        
        //using firebase
        /*
        newActivity = Activity()
        newActivity?.name = nameTextField.text!
        newActivity?.locationName = locationTextField.text!
        newActivity?.date = dateTextField.text!
        
        //convert image to NSData and then to base64 string
        let userImage:UIImage = imageView.image!
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        newActivity?.imageString = imageData.base64EncodedString(options: .lineLength64Characters)
 
        
        newActivity?.location = GeoPoint(latitude: currentUserLocation.coordinate.latitude, longitude: currentUserLocation.coordinate.longitude)
        
        Alamofire.request("https://ixlocationtwo.firebaseio.com/Activity.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON{
            response in
            
            print(response.response)
            print(response.result)
        
            switch response.result {
            case .success( _):
                self.delegate?.didSaveActivity(activity: self.newActivity!)
                self.dismiss(animated: true, completion: nil)
            case .failure: break
            }
        }
    */
        
        if (nameTextField.text?.isEmpty)!||(locationTextField.text?.isEmpty)!||(dateTextField.text?.isEmpty)!{
            //throw an error
            print("need to fill both categories")
            
        }
        else{
            dismiss(animated: true, completion: nil)
        }
 
    }

    @IBAction func cancelActivity(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        nameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()

        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set image to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
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
    
    
}
