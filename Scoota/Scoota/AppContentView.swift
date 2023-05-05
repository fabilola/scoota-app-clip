//
//  ContentView.swift
//  Scoota
//
//  Created by Dums, Fabiola on 17.01.23.
//

import SwiftUI

struct AppContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
