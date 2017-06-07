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

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Some navigation Items
        
            
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
    

