//
//  HelpButton.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct HelpButton: View {
    var body: some View {
        Text(.init(Constants.getHelpLink))
    }
}

struct HelpButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton()
    }
}
