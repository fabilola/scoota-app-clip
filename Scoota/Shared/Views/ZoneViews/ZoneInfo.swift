//
//  ZoneInfo.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct ZoneInfo: View {
    var zoneInfo: String
    var showIcons: Bool
    
    @Binding var mapSheetToggle: Bool
    @EnvironmentObject var data: ModelData
    
    var body: some View {
        GroupBox{
            VStack{
                HStack{
                    Text(Constants.zoneInfoTitle)
                        .fontWeight(.semibold)
                        .font(.body)
                        .frame(alignment: .leading)
                    Spacer()
                    
                    Image(systemName: "info.circle").foregroundColor(.accentColor)
                }.padding(.bottom, 2)
                
                Text(zoneInfo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .opacity(0.7)
                
                if showIcons
                {
                    ZoneLegend(showNormalZone: true)
                }
            }
        }
        .groupBoxStyle(BoxStyle())
        .onTapGesture{
            mapSheetToggle.toggle()
        }
        .sheet(isPresented: $mapSheetToggle){
            MapSheet()
                .edgesIgnoringSafeArea(.bottom)
                .background(Color(.systemGroupedBackground))
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}

struct ZoneInfo_Previews: PreviewProvider {
    static var previews: some View {
        ZoneInfo(
            zoneInfo: "Zone info lorem ipsum text", showIcons: true, mapSheetToggle: .constant(false)
        )
    }
}
