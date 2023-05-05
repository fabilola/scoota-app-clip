//
//  PaymentHandler.swift
//  Scoota
//
//  Created by Dums, Fabiola on 31.01.23.
//
/*
See LICENSE folder for this sample’s licensing information.

 https:developer.apple.com/documentation/passkit/apple_pay/offering_apple_pay_in_your_app
*/

import UIKit
import PassKit


typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler!

    // supported Card providers
    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .discover,
        .masterCard,
        .visa
    ]

    class func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
    }
    

    func startPayment(unlockFee: Double, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        let unlock = PKPaymentSummaryItem(label: "Unlock Fee", amount: NSDecimalNumber(string: "\(unlockFee)"), type: .final)
        let total = PKPaymentSummaryItem(label: "Scoota" , amount: NSDecimalNumber(string: "1.00"), type: .pending)
        paymentSummaryItems = [unlock, total]
        
        
        // Create a payment request.
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.example.scootaclipdemo"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "DE"
        paymentRequest.currencyCode = "EUR"
        paymentRequest.shippingType = .servicePickup
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.requiredShippingContactFields = [.emailAddress]
        
        // Display the payment request.
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Presented payment controller")
            } else {
                debugPrint("Failed to present payment controller")
                self.completionHandler(false)
            }
        })
    }
}

// Set up PKPaymentAuthorizationControllerDelegate conformance.

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        // Perform basic validation on the provided contact information.
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            // The payment sheet doesn't automatically dismiss once it has finished. Dismiss the payment sheet.
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
            }
        }
    }

}

