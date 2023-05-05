//
//  RideSummaryViewModel.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import Foundation

extension RideSummaryView {
    class RideSummaryViewViewModel : ObservableObject {
        
        private let ride: PreRide = load("preRideData.json")
        
        private var unlockFee: Double = 0.0
        private var pricePerMinute: Double = 0.0
        
        init(){
            self.unlockFee = ride.unlockFee
            self.pricePerMinute = ride.pricePerMin
        }
        
        func getAmount(rentalPeriodInSeconds: TimeInterval) -> String {
            let timeIntervalInSeconds = Double(rentalPeriodInSeconds) // seconds of rental
            let minutes: Double = (timeIntervalInSeconds / Double(60)).rounded(.up)
            let amount = unlockFee + (pricePerMinute * minutes)
            return String(format: "%.2f €", amount)
        }
        
        func getDuration(rentalPeriod: TimeInterval) -> String {
            return elapseString(timeInterval: rentalPeriod)
        }
    }
}
