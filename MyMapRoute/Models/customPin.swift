//
//  customPin.swift
//  MyMapRoute
//
//  Created by Sierra on 7/18/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var title : String?
    var subtitle : String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
