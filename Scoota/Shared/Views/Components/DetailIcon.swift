//
//  DetailIcon.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct DetailIcon: View {
    var systemName: String
    var caption: String
    var subcaption: String
    
    var body: some View {
        VStack{
            Image(systemName: systemName)
                .font(.system(size: 28))
                .padding(.bottom, 4)
            Text(caption)
                .font(.body)
                .fontWeight(.semibold)
            Text(subcaption)
                .font(.subheadline)
                .fontWeight(.regular)
                .opacity(0.7)
        }
    }
    
    struct DetailIcon_Previews: PreviewProvider {
        static var previews: some View {
            DetailIcon(
                systemName: "scooter", caption: "FP244", subcaption: "Scooter ID")
        }
    }
}
