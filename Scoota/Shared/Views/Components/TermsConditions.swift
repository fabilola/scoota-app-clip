//
//  TermsConditions.swift
//  Scoota
//
//  Created by Dums, Fabiola on 25.01.23.
//

import SwiftUI

struct TermsConditions: View {
    @Binding var termsAccepted: Bool
    
    var body: some View {
        HStack{
            Button {
                termsAccepted.toggle()
                
            } label: {
                termsAccepted ?
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 24))
                    .padding(.trailing) :
                Image(systemName: "square")
                    .foregroundColor(Color.black)
                    .font(.system(size: 24))
                    .padding(.trailing)
            }
            Text(Constants.termsAndConditions1)
                .font(.subheadline) +
            Text(.init(Constants.termsOfUseLink))
                .fontWeight(.semibold)
                .font(.subheadline) +
            Text(Constants.termsAndConditions2)
                .font(.subheadline) +
            Text(.init(Constants.privacyPolicyLink))
                .fontWeight(.semibold)
                .font(.subheadline)
     }
    }
}

struct TermsConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsConditions(termsAccepted: .constant(true))
    }
}
