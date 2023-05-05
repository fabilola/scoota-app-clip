//
//  ZoneIcon.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct IconTextCombination: View {
    var zoneColor: String?
    var systemName: String
    var caption: String
    
    var body: some View {
        HStack{
            if zoneColor != nil {
                ZStack{
                    Circle()
                        .frame(width: 23)
                        .foregroundColor(Color(zoneColor!))
                    getIcon(systemName: systemName)
                }
            } else {
                getIcon(systemName: systemName)
            }
            Text(caption)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(-10)
                .opacity(0.7)
        }
    }
   
    struct ZoneIcon_Previews: PreviewProvider {
        static var previews: some View {
            IconTextCombination(
                zoneColor: "Normalzone", systemName: "Noparking", caption: "Normal")
        }
    }
}
