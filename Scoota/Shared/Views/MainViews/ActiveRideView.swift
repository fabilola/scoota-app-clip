//
//  ActiveRideView.swift
//  Scoota
//
//  Created by Dums, Fabiola on 27.01.23.
//

import SwiftUI

struct ActiveRideView: View {
    
    @Binding var path: [Screen]
    @StateObject private var viewModel = ActiveRideViewViewModel()
    @EnvironmentObject var data: ModelData
    @State private var showAlertEnd = false
    @State private var showAlertPark = false
    
    var body: some View {
        ScrollView{
            VStack{
                Header(subtitle: Constants.activeRideSubtitle)
                    .padding(.bottom, 16)
                
                HStack{
                    Image(systemName: "clock")
                    Text(elapseString(timeInterval: data.elapsedTime))
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .padding(.bottom, 4)
                
                ZoneIndicator(activeZone: data.activeZone)
                    .padding(.bottom, 12)
                
                HStack(alignment:.lastTextBaseline){
                    DetailIcon(systemName: "scooter", caption: data.scooterId, subcaption: "Scooter ID")
                    
                    Spacer()
                    
                    DetailIcon(systemName: "battery.100",
                               caption: viewModel.remainingDistanceMin(distance: data.distanceTravelled ),
                               subcaption:
                                viewModel.remainingDistanceKm(distance: data.distanceTravelled)
                    )
                    
                    Spacer()
                    
                    DetailIcon(systemName: "location", caption: distanceString(distance: data.distanceTravelled), subcaption: Constants.rideDistance)
                    
                }
                .padding(.bottom, 12
                )
                
                ZStack{
                    Rectangle()
                        .fill(Color("Slowzone")
                            .opacity(0.4))
                        .cornerRadius(8)
                    HStack{
                        Image(systemName: "exclamationmark.triangle")
                        Text(Constants.activeRideHintText)
                            .font(.caption)
                    }
                    .padding()
                    .frame(alignment: .leading)
                   
                }
                .padding(.bottom, 8)
            
                ZoneInfo(
                    zoneInfo: Constants.activeRideZoneInfo,
                    showIcons: viewModel.showIcons,
                    mapSheetToggle: $data.showMapSheet
                ).padding(.bottom, 8)
                
                RidingInfo(
                    showIcons: viewModel.showIcons)
                
            }.padding(.horizontal, 20)
                .alert(Constants.activeRideAlertNoParkTitle, isPresented: $showAlertPark, actions: {
                    Button("OK", role: .cancel) {}
                }, message: {
                    Text(Constants.activeRideAlertNoPark)
                })
                .alert(isPresented:$showAlertEnd) {
                            Alert(
                                title: Text(Constants.activeRideAlertEndRideTitle),
                                message: Text(Constants.activeRideAlertEndRide),
                                primaryButton:.destructive(Text(Constants.activeRideAlertEndRideCancel)) {
                                    showAlertEnd = false
                                  },
                                secondaryButton: .destructive(Text(Constants.activeRideAlertEndRideConfirm)) {
                                    path.append(Screen.summary)
                                    data.stopRide()
                                    showAlertEnd = false
                                }
                            )
                        }
            
        }.frame(maxWidth: UIScreen.main.bounds.width)
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            
            .safeAreaInset(edge: .bottom){
                
                EndRideFooter(callback: pushNavigation)
            }
    }
    
    private func pushNavigation (){
        if data.activeZone == ZoneType.nopark.getZone(){
            showAlertPark.toggle()
        } else {
            showAlertEnd.toggle()
        }
    }
}

struct ActiveRideView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveRideView(path: .constant([Screen.active]))
            .environmentObject(ModelData())
    }
}
