//
//  MapSettingsTableViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/7/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit

class MapSettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let pinColor = UserDefaults.standard.string(forKey: "pinColor")
        
        if indexPath.section == 0 && pinColor == nil {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 0 && indexPath.row == 0 && pinColor == "red" {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 0 && indexPath.row == 1 && pinColor == "green" {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 0 && indexPath.row == 2 && pinColor == "blue" {
            cell.accessoryType = .checkmark
        }
        
        
    }
    
    /*
     Different map types
     map.mapType = .hybrid              == section 2, row 0
     map.mapType = .hybridFlyover       == section 2, row 1
     map.mapType = .satellite           == section 2, row 2
     map.mapType = .satelliteFlyover    == section 2, row 3
     map.mapType = .standard            == section 2, row 4
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            // First de-select all
            tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.accessoryType = .none
           
           
            
            // Determine which cell was chosen
            if let cell = tableView.cellForRow(at: indexPath) {
                if indexPath.row == 0 {
                    UserDefaults.standard.set("red", forKey: "pinColor")
                }
                
                if indexPath.row == 1 {
                    UserDefaults.standard.set("green", forKey: "pinColor")
                }
                
                if indexPath.row == 2 {
                    UserDefaults.standard.set("blue", forKey: "pinColor")
                }
                
                cell.accessoryType = .checkmark
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

}
