//
//  ContentView.swift
//  ScootaClip
//
//  Created by Dums, Fabiola on 19.01.23.
//

import SwiftUI

enum Screen {
    case rental, active, summary
}

struct ContentView: View {
    @State private var path: [Screen] = [.rental]
    @StateObject var data = ModelData()
    @State var showAlert = false
    
    var body: some View {
        
        NavigationStack(path: $path){
            Text("App Clip")
                .navigationDestination(for: Screen.self) {  view in
                    switch view {
                    case .rental:
                        RentalOverview(path: $path)
                            .environmentObject(data)
                            .onAppear{
                                data.setup()
                            }
                            .navigationBarBackButtonHidden(true)
                            .preferredColorScheme(.light)
                    case .active:
                        ActiveRideView(path: $path)
                            .environmentObject(data)
                            .navigationBarBackButtonHidden(true)
                            .preferredColorScheme(.light)
                    case .summary:
                        RideSummaryView(path: $path)
                            .environmentObject(data)
                            .navigationBarBackButtonHidden(true)
                            .preferredColorScheme(.light)
                    }
                }
        }
        .preferredColorScheme(.light)
        .alert("No scooter ID", isPresented: $showAlert, actions : {
            Button("OK", role: .cancel) {}
        }, message : {
            Text(Constants.rentalOverviewNoID)
        })
        .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
    }
    
    public func handleUserActivity(_ userActivity: NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let urlComponents = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = urlComponents.queryItems,
            let id = queryItems.first(where: {$0.name == "id"})?.value else {
            
            showAlert.toggle()
            data.scooterId = "NF404"
            path = [.rental]
            return
        }
        data.scooterId = String(id)
        path = [.rental]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
