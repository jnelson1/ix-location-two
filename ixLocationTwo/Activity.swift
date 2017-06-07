//
//  Activity.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    
    var name: String
    var locationName: String
    var date: String
    var image: UIImage?
    var location: GeoPoint
    
    init?() {
        self.name = ""
        self.locationName = ""
        self.date=""
        self.image = nil
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
    }
    
}
