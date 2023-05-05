//
//  DetailIconBar.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct DetailIconBar: View {
    var scooterId: String
    var rangeDuration: String
    var rangeInKm: String
    var unlockFee: String
    var pricePerMin: String

    var body: some View {
        HStack(alignment:.lastTextBaseline){
            DetailIcon(systemName: "scooter", caption: scooterId, subcaption: "Scooter ID")
            Spacer()
            DetailIcon(systemName: "battery.100", caption: rangeDuration, subcaption: rangeInKm)
            Spacer()
            DetailIcon(systemName: "eurosign", caption: pricePerMin, subcaption: unlockFee)
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
    }
}

struct DetailIconBar_Previews: PreviewProvider {
    static var previews: some View {
        DetailIconBar(
            scooterId: "FP302",
            rangeDuration: "~1h 12m",
            rangeInKm: "5km range",
            unlockFee: "+ 1€ to start",
            pricePerMin: "0.31€/min "
            )
    }
}
