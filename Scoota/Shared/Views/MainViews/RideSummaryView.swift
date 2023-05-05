//
//  RideSummaryView.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import SwiftUI

struct RideSummaryView: View {
    @Binding var path: [Screen]
    @EnvironmentObject var data: ModelData
    @StateObject private var viewModel = RideSummaryViewViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                Header(subtitle: Constants.rideSummarySubtitle)
                    .padding(.bottom, 16)
                
                HStack{
                    Image(systemName: "clock")
                    Text(viewModel.getDuration(rentalPeriod: data.rentalPeriodInSeconds))
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .padding(.bottom, 4)
                
                ZoneIndicator()
                    .padding(.bottom, 12)
                
                HStack(alignment:.lastTextBaseline){
                    DetailIcon(systemName: "scooter", caption: data.scooterId, subcaption: "Scooter ID")
                    
                    Spacer()
                    
                    DetailIcon(systemName: "eurosign", caption:
                                
                                viewModel.getAmount(rentalPeriodInSeconds: data.rentalPeriodInSeconds),
                               subcaption: Constants.rideSummaryAmount)
                    
                    Spacer()
                    
                    DetailIcon(systemName: "location",
                               caption: distanceString(distance: data.distanceTravelled)
                               , subcaption: Constants.rideDistance)
                    
                }
                .padding(.bottom, 40)
                
                GroupBox{
                    Text(Constants.rideSummaryFullAppTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                        .font(.body)
                    Text(Constants.rideSummaryFullAppText)
                        .padding(.bottom, 4)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .opacity(0.7)
                    Button{
                    }label: {
                        Text(Constants.rideSummaryFullAppButton)
                            .fontWeight(.semibold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                            .padding()
                    }
                    
                }.groupBoxStyle(BoxStyle())
                
            }.padding(.horizontal, 20)
            
                .frame(maxWidth: UIScreen.main.bounds.width)
            
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct RideSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RideSummaryView(path: .constant([Screen.active]))
            .environmentObject(ModelData())
    }
}
