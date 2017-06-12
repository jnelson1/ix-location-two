//
//  Activity.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation
import UIKit
//import Gloss
import Realm

class Activity: RLMObject {
    dynamic var name = ""
    dynamic var locationName = ""
    dynamic var date = ""
    dynamic var location: GeoPoint?
}


//firebase activity
/*
class Activity: Decodable, Glossy{
    
    var name: String?
    var locationName: String?
    var date: String?
    var imageString: String?
    var location: GeoPoint?
    
    
    
    init?() {
        self.name = ""
        self.locationName = ""
        self.date=""
        self.imageString = ""
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
    }
    
    required init?(json: JSON) {
        self.name = "name" <~~ json
        self.locationName = "locationName" <~~ json
        self.date = "date" <~~ json
        self.imageString = "imageString" <~~ json
        self.location = "location" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "locationName" ~~> self.locationName,
            "date" ~~> self.date,
            "imageString" ~~> self.imageString,
            "location" ~~> self.location
            ])
    }
 
    
}
 */
