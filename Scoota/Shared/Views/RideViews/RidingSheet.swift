//
//  RidingSheet.swift
//  Scoota
//
//  Created by Dums, Fabiola on 16.02.23.
//

import SwiftUI

struct RidingSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ZStack{
                Text(Constants.ridingSheetTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button{
                    dismiss()
                }label: {
                    Circle()
                        .fill(Color(.tertiarySystemFill))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.secondary)
                        )
                }.padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            VStack(alignment: .listRowSeparatorLeading){
                HStack {
                    getIcon(systemName: "Adultsonly")
                        .font(.system(size: 28))
                        .padding(.trailing, 16)
                    Text(Constants.ridingSheetAge)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(-10)
                }.padding(.bottom, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    getIcon(systemName: "person.2.slash")
                        .font(.system(size: 28))
                        .padding(.trailing, 16)
                    Text(Constants.ridingSheetPerson)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(-10)
                }
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    getIcon(systemName: "hand.raised.slash")
                        .font(.system(size: 28))
                        .padding(.trailing, 16)
                    Text(Constants.ridingSheetInfluence)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(-10)
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
            Spacer()
            Text(Constants.ridingSheetMore)
            Text(.init(Constants.learnRideLink))
            Spacer()
        }
    }
    
    struct RidingSheet_Previews: PreviewProvider {
        static var previews: some View {
            RidingSheet()
        }
    }
}
