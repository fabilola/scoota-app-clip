//
//  RentalOverview.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct RentalOverview: View {
    @State var mapSheetToggle: Bool = false
    @Binding var path: [Screen]
    @EnvironmentObject var data: ModelData
    @StateObject private var viewModel = RentalOverviewViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                Header(subtitle: Constants.rentalOverviewSubtitle)
                    .padding(.bottom, 20)
                
                ZoneIndicator()
                    .padding(.bottom, 12)
                
                HStack(alignment:.lastTextBaseline){
                    DetailIcon(systemName: "scooter", caption: data.scooterId, subcaption: "Scooter ID")
                    
                    Spacer()
                    
                    DetailIcon(systemName: "battery.100", caption: viewModel.rangeInMin, subcaption: viewModel.rangeInKm)
                    
                    Spacer()
                    
                    DetailIcon(systemName: "eurosign", caption: viewModel.pricePerMin, subcaption: viewModel.unlockFee)
                    
                }
                .padding(.bottom, 20)
                
                ZoneInfo(
                    zoneInfo: Constants.rentalOverviewZoneInfo,
                    showIcons: viewModel.showIcons,
                    mapSheetToggle: $mapSheetToggle
                    
                ).padding(.bottom, 8)
                
                RidingInfo(showIcons: viewModel.showIcons)
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: UIScreen.main.bounds.width)
        }
        .safeAreaInset(edge: .bottom){
            ApplePayFooter(pay: viewModel.pay, termsAccepted: $viewModel.termsAccepted, showHint: viewModel.showTCWarning)
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .onAppear{
            viewModel.paymentSuccess = false
        }.onDisappear{
            viewModel.paymentSuccess = false
        }
        .onChange(of: viewModel.paymentSuccess) { value in
            if value {
                pushNavigation()
            }
        }
        .onChange(of: path) { value in 
            viewModel.termsAccepted = false
        }
        
    }
    
    private func pushNavigation (){
        path.append(Screen.active)
        data.startRide()
    }
    
}

struct RentalOverview_Previews: PreviewProvider {
    static var previews: some View {
        RentalOverview(path: .constant([Screen.active]))
            .environmentObject(ModelData())
    }
}
