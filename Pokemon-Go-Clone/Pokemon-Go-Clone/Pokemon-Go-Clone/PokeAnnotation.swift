//
//  PokeAnnotation.swift
//  Pokemon-Go-Clone
//
//  Created by Thomas Cowern New on 9/17/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    
    init(coord:CLLocationCoordinate2D, pokemon:Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
    
    
    
    
}
