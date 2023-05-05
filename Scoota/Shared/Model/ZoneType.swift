//
//  ZoneType.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import Foundation

enum ZoneType: Decodable, Equatable {
    case normal, slow, nopark
    case unknown(value: String)
    
    func getZone() -> Zone {
        switch(self) {
        case .normal:
            return Zone(zoneColor: "Normalzone", zoneTitle: "No special zone", zoneDescription: "Have fun riding", zoneIcon: "checkmark.circle", zoneShortDescription: "Normal")
        case .slow:
            return Zone(zoneColor: "Slowzone", zoneTitle: "Slow zone", zoneDescription: "Reduced speed", zoneIcon: "tortoise", zoneShortDescription: "Slow")
        case .nopark:
            return Zone(zoneColor: "Noparkzone", zoneTitle: "No-parking zone", zoneDescription: "Parking prohibited", zoneIcon: "Noparking", zoneShortDescription: "No-parking")
        case .unknown(value: let value):
            return Zone(zoneColor: "Noparkzone", zoneTitle: value, zoneDescription: "Zonetype unknown", zoneIcon: "Noparking", zoneShortDescription: "unknown")
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "slow": self =  ZoneType.slow
        case "nopark": self = ZoneType.nopark
        case "normal": self = ZoneType.normal
        default:
            self = ZoneType.unknown(value: status ?? "unknown")
        }
    }
}
