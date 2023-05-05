//
//  StickyFooter.swift
//  Scoota
//
//  Created by Dums, Fabiola on 26.01.23.
//

import SwiftUI
import PassKit

struct ApplePayFooter: View {
    var pay: () -> Void
    @Binding var termsAccepted: Bool
    var showHint: Bool
    
    var body: some View {
        VStack{
            TermsConditions(termsAccepted: $termsAccepted)
                .padding(.top, 12)
                .padding(.bottom, showHint ? 0: 16)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            if(showHint){
                Label(Constants.hintTextPayment, systemImage: "exclamationmark.triangle")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 4)
                    .padding(.bottom, 16)
                    .padding(.horizontal)
            }
            PayWithApplePayButton(
                .rent,
                action: self.pay
            )
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 16)
            HelpButton()
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.systemGroupedBackground).opacity(0.9), Color(.systemGroupedBackground)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct StickyFooter_Previews: PreviewProvider {
    static var previews: some View {
        ApplePayFooter(pay: {}, termsAccepted: .constant(true), showHint: true)
    }
}
