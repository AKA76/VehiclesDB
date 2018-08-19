//
//  AKBike.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 19/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import Foundation

enum BikeType {
    case scooter
    case sport
    case chopper
}
class AKBike : AKVehicle {
    // let bikeType : BikeType = .chopper
    var bikeType : String = ""
}
