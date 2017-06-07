//
//  AddActivityViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: AddActivityDelegate?
    var newActivity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActivity(_ sender: Any) {
        let newActivity = Activity()
        newActivity?.name = nameTextField.text!
        newActivity?.locationName = locationTextField.text!
        newActivity?.date = dateTextField.text!
        delegate?.didSaveActivity(activity: newActivity!)
        if (nameTextField.text?.isEmpty)!||(locationTextField.text?.isEmpty)!||(dateTextField.text?.isEmpty)!{
            //throw an error
            print("need to fill both categories")
            
        }
        else{
            dismiss(animated: true, completion: nil)
        }
 
    }

    @IBAction func cancelActivity(_ sender: Any) {
        delegate?.didCancelActivity()
        dismiss(animated: true, completion: nil)
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
