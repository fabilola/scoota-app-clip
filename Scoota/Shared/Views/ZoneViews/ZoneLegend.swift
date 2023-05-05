//
//  ZoneLegend.swift
//  Scoota
//
//  Created by Dums, Fabiola on 14.02.23.
//

import SwiftUI

struct ZoneLegend: View {
    var showNormalZone: Bool
    
    var body: some View {
        HStack{
            IconTextCombination(
                zoneColor: ZoneType.slow.getZone().zoneColor,
                systemName: ZoneType.slow.getZone().zoneIcon,
                caption: ZoneType.slow.getZone().zoneShortDescription)
            Spacer()
            IconTextCombination(
                zoneColor: ZoneType.nopark.getZone().zoneColor,
                systemName: ZoneType.nopark.getZone().zoneIcon,
                caption: ZoneType.nopark.getZone().zoneShortDescription)
            if showNormalZone {
                Spacer()
                IconTextCombination(
                    zoneColor: ZoneType.normal.getZone().zoneColor,
                    systemName: ZoneType.normal.getZone().zoneIcon,
                    caption: ZoneType.normal.getZone().zoneShortDescription)
            }
        }
    }
}

struct ZoneLegend_Previews: PreviewProvider {
    static var previews: some View {
        ZoneLegend(showNormalZone: true)
    }
}
