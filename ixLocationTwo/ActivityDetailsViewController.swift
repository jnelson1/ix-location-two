//
//  ActivityDetailsViewController.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/7/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseStorage


class ActivityDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storageRef = Storage.storage().reference()
        if let imageName = activity?.name {
            let imagesRef = storageRef.child("images/\(imageName).jpg")
            imagesRef.getData(maxSize: 10 * 1024 * 1024, completion: {(data, error) in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print(error.localizedDescription)
                } else {
                    // Data for "images/island.jpg" is returned
                    self.activity?.image = UIImage(data: data!)
                }
                
            })
        }

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
        imageView.image = activity?.image
        

        /*
        let dataDecoded:NSData = NSData(base64Encoded: (activity?.imageString!)!, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        imageView?.image = decodedimage*/

    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


