//
//  GeoPoint.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/6/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation
import Gloss
import Realm

//need to implement Glossy and Decodable for firebase code
class GeoPoint: RLMObject {
    //realm
    dynamic var lat = 0.0
    dynamic var lng = 0.0
    
    
    //firebase
    /*
    var lat: Double?
    var lng: Double?


    init() {
        self.lat = 0.0
        self.lng = 0.0
    }
 
    init(latitude lat: Double, longitude lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    required init?(json: JSON){
        self.lat = "lat" <~~ json
        self.lng = "lng" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "lat" ~~> self.lat, "lng" ~~> self.lng])
    }
 */
    
    
}
