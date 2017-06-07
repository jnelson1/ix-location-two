//
//  ProfileChangeViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/7/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit

class ProfileChangeViewController: UIViewController {

    @IBOutlet weak var profileChangeTextField: UITextField!
    
    var delegate1: ProfileChangeDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveName(_ sender: Any) {
        if(profileChangeTextField.text?.isEmpty)!{
            //throw an error
            print("need to write something")
            
        }
        else{
            let newName = profileChangeTextField.text
            delegate1?.didSaveProfileChange(name: newName!)
            self.dismiss(animated: true, completion: nil)
        }

    }

    @IBAction func cancelName(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
