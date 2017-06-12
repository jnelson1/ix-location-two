//
//  ActivityDetailsViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/7/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit

class ActivityDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = activity?.name
        locationNameLabel.text = activity?.locationName
        dateLabel.text = activity?.date
        /*
        let dataDecoded:NSData = NSData(base64Encoded: (activity?.imageString!)!, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        imageView?.image = decodedimage*/

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
