//
//  TempView.swift
//  Scoota
//
//  Created by Dums, Fabiola on 13.02.23.
//

import SwiftUI

struct MapSheet: View {
    @EnvironmentObject var data: ModelData
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            VStack{
                ZStack{
                    Text(Constants.mapSheetTitle)
                        .padding([.top, .bottom], 12)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button{
                        dismiss()
                    }label: {
                        Circle()
                            .fill(Color(.tertiarySystemFill))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.secondary)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text(Constants.mapSheetInfo)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZoneLegend(showNormalZone: false)
                    .padding(.horizontal)
            }.padding()
            MapView(centerCoor: $data.centerCoordinate)
        }
    }
}

struct MapSheet_Previews: PreviewProvider {
    static var previews: some View {
        MapSheet()
    }
}
