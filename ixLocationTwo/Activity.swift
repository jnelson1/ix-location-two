//
//  Activity.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation
import UIKit
import Gloss

class Activity: Decodable, Glossy{
    
    var name: String?
    var locationName: String?
    var date: String?
    //var image: UIImage?
    var location: GeoPoint?
    
    init?() {
        self.name = ""
        self.locationName = ""
        self.date=""
        //self.image = nil
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
    }
    
    required init?(json: JSON) {
        self.name = "name" <~~ json
        self.locationName = "locationName" <~~ json
        self.date = "date" <~~ json

        self.location = "location" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "locationName" ~~> self.locationName,
            "date" ~~> self.date,
            "location" ~~> self.location
            ])
    }
 
    
}
