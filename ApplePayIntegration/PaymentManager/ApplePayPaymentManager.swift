//
//  ApplePayPaymentManager.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

typealias ApplePayPaymentCompletion = (Result<ApplePayPayment.TransactionResponse, ApplePayError>) -> Void

protocol ApplePayPaymentManager {
    /**
     Determine if the user's device can use Apple Pay in-app payment services or not with the specified payment methods.
     - parameter paymentMethods: Set of payment methods accepted by the payment service provider in charge of processing the transaction.
     - parameter capabilities:   Set of merchant capabilities inherent to the specified payment methods.
     - returns: A state object indicating if the current device can offer in-app Apple Pay services for the specified requirements.
     */
    func canUseApplePay(
        withPaymentMethods paymentMethods: [ApplePayPayment.PaymentMethod],
        andCapabilities capabilities: [ApplePayPayment.MerchantCapability]
    ) -> ApplePayPayment.State
    
    /**
     Start the Apple Pay flow showing the payment sheet and requesting user both payment method and biometric identification, then perform the payment.
     - parameter request:        Specific information needed to authorize the Apple Pay transaction.
     - parameter paymentService: Remote service to actually perform the transaction using the payment info.
     - parameter completion:     Callback to asynchronously return the outcome of the Apple Pay transaction.
     
     - important: Completion handler function might be executed in a secondary thread
     */
    func startApplePayTransaction(
        withRequest request: ApplePayPayment.TransactionRequest,
        paymentService: ApplePayRemotePaymentService,
        completion: @escaping ApplePayPaymentCompletion
     )
}
