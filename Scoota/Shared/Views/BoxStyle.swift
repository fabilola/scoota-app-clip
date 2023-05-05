//
//  BoxStyle.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import Foundation
import SwiftUI

struct BoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
