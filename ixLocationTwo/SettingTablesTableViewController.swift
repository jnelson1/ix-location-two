//
//  SettingTablesTableViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit

class SettingTablesTableViewController: UITableViewController, ProfileChangeDelegate {

    @IBOutlet weak var profileNameLabel: UILabel!
    
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

    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let mapType = UserDefaults.standard.string(forKey: "mapType")
        
        if indexPath.section == 2 && mapType == nil {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 2 && indexPath.row == 0 && mapType == "hybrid" {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 2 && indexPath.row == 1 && mapType == "standard" {
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
        
        if indexPath.section == 2 {
            
            // First de-select all
            tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 1, section: 2))?.accessoryType = .none
            
            
            // Determine which cell was chosen
            if let cell = tableView.cellForRow(at: indexPath) {
                if indexPath.row == 0 {
                    UserDefaults.standard.set("hybrid", forKey: "mapType")
                }
                
                if indexPath.row == 1 {
                    UserDefaults.standard.set("standard", forKey: "mapType")
                }
                
                cell.accessoryType = .checkmark
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profile"{
            let navigationViewController = segue.destination as! UINavigationController
            let profileChangeViewController = navigationViewController.topViewController as! ProfileChangeViewController
            
            profileChangeViewController.delegate1 = self
           
        }
        
        }
    func didSaveProfileChange(name: String){
        profileNameLabel?.text = name
        self.tableView.reloadData()
    }
    func didCancelProfileChange()
    {
        
    }
        

            }
    

