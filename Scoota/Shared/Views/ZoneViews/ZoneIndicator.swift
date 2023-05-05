//
//  ZoneIndicator.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct ZoneIndicator: View {
    @State private var wave = false
    var activeZone: Zone? = nil
    @EnvironmentObject var data: ModelData
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 160,
                       height: 160)
                .foregroundColor(activeZone != nil ? Color(
                   activeZone!.zoneColor) :Color("Inactivezone"))
            if activeZone != nil{
                Circle()
                    .frame(width: 220,
                           height: 220)
                    .foregroundColor( 
                        Color(
                            activeZone!.zoneColor)
                    )
                    .scaleEffect(wave ? 1 : 0.78)
                
                    .opacity(wave ? 0.2 : 0.4)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).speed(0.5), value: wave)
                    .onAppear(){
                        self.wave.toggle()
                    }
            } else {
                Circle()
                    .frame(width: 220,
                           height: 220)
                    .foregroundColor(Color("Inactivezone"))
                    .opacity(0.4)
            }
            if activeZone != nil {
                VStack{
                    getIcon(systemName:  activeZone!.zoneIcon)
                        .font(.system(size: 36))
                    Text(activeZone!.zoneTitle)
                        .font(.body)
                        .fontWeight(.semibold)
                    Text(activeZone!.zoneDescription)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
            } else {
                Image("Scootaimage")
                    .scaleEffect(0.20)
                    .frame(height: 80)
            }
        }
        .onTapGesture {
            if activeZone != nil {
                data.showMapSheet.toggle()
            }
        }
    }
}

struct ZoneIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ZoneIndicator(activeZone: Zone(zoneColor: "Normalzone", zoneTitle: "No special zone", zoneDescription: "Have fun", zoneIcon: "checkmark.circle", zoneShortDescription: "normal"))
            .environmentObject(ModelData())
    }
}
