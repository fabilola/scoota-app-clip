//
//  RentalOverviewViewModel.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import Foundation

extension RentalOverview {
    class RentalOverviewViewModel : ObservableObject {
        
        private let ride: PreRide = load("preRideData.json")

        @Published var showIcons: Bool = true
        
        @Published var termsAccepted: Bool = false
        @Published var showTCWarning: Bool = false
        
        @Published var unlockFee: String = ""
        @Published var rangeInKm: String = ""
        @Published var rangeInMin: String = ""
        @Published var pricePerMin: String = ""
        
        let paymentHandler = PaymentHandler()
        @Published var paymentSuccess = false
        
        init() {
            self.unlockFee = getUnlockFee()
            self.rangeInKm = getRangeInKm()
            self.rangeInMin = getRangeInMin()
            self.pricePerMin = getPricePerMin()
        }
        
       private func getRangeInKm () -> String {
            return String(format: "%.1f km", self.ride.rangeInKm)
        }
        
        private func getRangeInMin () -> String {
            return computeBatteryMinString(minutes: self.ride.rangeInMin)
        }
        
       private func getPricePerMin () -> String {
            return String(format: "%.2f €/min", self.ride.pricePerMin)
        }
        
        private func getUnlockFee () -> String {
            return String(format: "%.2f € to unlock", self.ride.unlockFee)
        }
        
        func pay () {
            if (self.termsAccepted){
                paymentHandler.startPayment(unlockFee: ride.unlockFee) { success in
                    self.paymentSuccess = success
                }
            } else {
                showTCWarning = true
            }
        }
    }
}



