//
//  EndRideFooter.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import SwiftUI

struct EndRideFooter: View {
    @EnvironmentObject var data : ModelData
    @State private var showAlertEnd: Bool = false
    
    var callback: () -> Void
    var body: some View {
        VStack{
            Button{
                   callback()
            }label: {
                Text(Constants.endRideButton)
                    .fontWeight(.semibold)
                    .frame(width: 350)
                    .frame(height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding()
            }.padding(.bottom, 12)
            HelpButton()
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.systemGroupedBackground).opacity(0.9), Color(.systemGroupedBackground)]), startPoint: .top, endPoint: .bottom)
                )
    }
}

struct EndRideFooter_Previews: PreviewProvider {
    static var previews: some View {
        EndRideFooter(callback: {})
    }
}
