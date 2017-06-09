//
//  PinAnnotation.swift
//  ixLocationTwo
//
//  Created by Jon Nelson1 on 6/9/17.
//  Copyright © 2017 Jon Nelson. All rights reserved.
//

import Foundation
import MapKit

class PinAnnotation: MKPointAnnotation{
    var activity: Activity?
    
    init?(activity: Activity) {
        self.activity = activity
        super.init()
    }
   }
