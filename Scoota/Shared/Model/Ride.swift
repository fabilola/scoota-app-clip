//
//  Ride.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import Foundation

struct Ride: Codable, Hashable {
    var rangeInKm: Double
    var rangeInMin: Int
    var distance: Double
    var durationInMin: Int
}
