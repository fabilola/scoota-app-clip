//
//  RentalOverviewViewModel.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import Foundation

extension ActiveRideView {
    class ActiveRideViewViewModel : ObservableObject {
        
        private let ride: Ride = load("rideData.json")

        @Published var showIcons: Bool = false

        @Published var activeZone: Zone = ZoneType.normal.getZone()
        
        private var initialMinRange = 0
        private var initialKmRange = 0.0
        
        init(){
            self.initialMinRange = ride.rangeInMin
            self.initialKmRange = ride.distance
        }
        
        func remainingDistanceMin(distance: Double) -> String {
            let travel = distance * 10
            let remainder = self.initialMinRange - (Int(travel) * 2)
            return computeBatteryMinString(minutes: remainder)
        }
        
        func remainingDistanceKm(distance: Double) -> String {
            let remaining = self.initialKmRange - distance
            return String(format: "%.1f km", remaining)
        }
    }
}
