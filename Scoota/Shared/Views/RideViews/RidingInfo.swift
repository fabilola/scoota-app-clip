//
//  RidingInfo.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct RidingInfo: View {
    var showIcons: Bool
    @State private var sheetToggle: Bool = false
    
    var body: some View {
        GroupBox{
            VStack{
                HStack{
                    Text(Constants.ridingInfoTitle)
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "info.circle").foregroundColor(.accentColor)
                }                
            }.padding(.bottom, 4)
            
            if showIcons {
                HStack(spacing: 3){
                    IconTextCombination(
                        systemName: "Adultsonly",
                        caption: Constants.ridingInfoAge)
                    Spacer()
                    IconTextCombination( systemName: "person.2.slash", caption: Constants.ridingInfoPerson)
                    Spacer()
                    IconTextCombination( systemName: "hand.raised.slash", caption: Constants.ridingInfoInfluence)
                }
            } else {
                Text(Constants.activeRideRideInfo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .opacity(0.7)
            }
        }
        .groupBoxStyle(BoxStyle())
        .onTapGesture {
            sheetToggle.toggle()
        }
        .sheet(isPresented: $sheetToggle){
            RidingSheet()
                .presentationDetents([.medium, .fraction(0.7)])
                .edgesIgnoringSafeArea(.bottom)
                .background(Color(.systemGroupedBackground))
        }
    }
}

struct RidingInfo_Previews: PreviewProvider {
    static var previews: some View {
        RidingInfo(
        showIcons: true)
    }
}
