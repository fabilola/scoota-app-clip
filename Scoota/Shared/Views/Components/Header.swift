//
//  Header.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct Header: View {
    
    var subtitle: String
    
    var body: some View {
        VStack{
            Text("Scoota")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
            Text(subtitle)
                .font(.subheadline)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {        
        Header(subtitle: "Hello")
    }
}

