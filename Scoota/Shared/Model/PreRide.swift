//
//  PreRide.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import Foundation

struct PreRide: Codable, Hashable {
    var rangeInKm: Double
    var rangeInMin: Int
    var pricePerMin: Double
    var unlockFee: Double
}
