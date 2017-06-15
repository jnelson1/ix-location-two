
//
//  ActivityLogTableViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit
import Alamofire
import Gloss
import FirebaseStorage
//import Realm

class ActivityLogTableViewController: UITableViewController{
    //realm
    /*
    var activities: RLMResults<Activity> {
        get {
            return Activity.allObjects() as! RLMResults<Activity>
        }
    }
    */
    //firebase
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func viewDidAppear(_ animated: Bool) {
        self.activities = []
        Alamofire.request("https://ixlocationtwo.firebaseio.com/Activity.json").responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                let response = JSON as? NSDictionary
                
                for (key, value) in response! {
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
                        }
                    }
                    
                    self.activities.append(activity!)
                    
                }
                self.tableView.reloadData()
                for activity in self.activities {
                    
                    let storageRef = Storage.storage().reference()
                    if let imageName = activity.name {
                        let imagesRef = storageRef.child("images/\(imageName).jpg")
                    
                    imagesRef.getData(maxSize: 10 * 1024 * 1024, completion: {(data, error) in
                        
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print(error.localizedDescription)
                        } else {
                            // Data for "images/island.jpg" is returned
                            activity.image = UIImage(data: data!)

                            self.tableView.reloadData()
                        }
                        
                    })
                    
                }
                
            }
        }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Int(activities.count)
        return activities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activity1", for: indexPath)
        
        //configure cell
        cell.textLabel?.text = activities[(indexPath.row)].name
        cell.detailTextLabel?.text = activities[(indexPath.row)].locationName
        if let image = activities[indexPath.row].image {
            cell.imageView?.image = image
        }
        //display image
        /*
        let dataDecoded:NSData = NSData(base64Encoded: activities[indexPath.row].imageString!, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        cell.imageView?.image = decodedimage
*/
        
        return cell
    }
    
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "navToActivityDetail"{
            let activityDetailsViewController = segue.destination as! ActivityDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            activityDetailsViewController.activity = activities[(indexPath?.row)!]
        }
    }
 

    
  
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


