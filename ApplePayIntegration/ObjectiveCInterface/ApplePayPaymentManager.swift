//
//  ApplePayPaymentManager.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Component in charge of the Apple Pay payment flow, offering high-level APIs to start an Apple Pay transaction in-app.
 */
@objc public class ApplePayPaymentManager: NSObject {
    private let internalPaymentManager: ApplePayPaymentManagerInterface = ApplePayPayment.StandardPaymentManager()
    
    /**
     Determine if the user's device can use Apple Pay in-app payment services or not with the specified payment methods.
     - parameter paymentMethods: Set of payment methods accepted by the payment service provider in charge of processing the transaction.
     - parameter capabilities:   Set of merchant capabilities inherent to the specified payment methods.
     - returns: A state object indicating if the current device can offer in-app Apple Pay services for the specified requirements.
     */
    @objc public func canUseApplePay(
        withPaymentMethods paymentMethods: [PRPaymentMethod],
        andCapabilities capabilities: [PRMerchantCapability]
    ) -> PRApplePayPaymentState {
        // map input to domain types
        let domainPaymentMethods = paymentMethods.map(\.domainPaymentMethod)
        let domainMerchantCapabilities = capabilities.map(\.domainMerchantCapability)
        
        // execute service
        let domainApplePayState = self.internalPaymentManager.canUseApplePay(
            withPaymentMethods: domainPaymentMethods,
            andCapabilities: domainMerchantCapabilities
        )
        
        // map output to objective-c compatible one
        return .from(domainApplePayState: domainApplePayState)
    }
    
    /**
     Start the Apple Pay flow showing the payment sheet, requesting user both payment method and biometric identification, and perform the payment.
     - parameter request:            Specific information needed to authorize and start the Apple Pay transaction.
     - parameter paymentService:     Interface to the remote service which actually perform the transaction by means of the payment information.
     - parameter completionDelegate: Delegate containing the completion handler function, to asynchronously return the outcome of the Apple Pay transaction.
     
     - important: Completion handler function might be executed in a secondary thread.
     */
    @objc public func startApplePayTransaction(
        withRequest request: PRTransactionRequest,
        paymentService: PRRemotePaymentService,
        completionDelegate: PRPaymentCompletionDelegate
    ) {
        // map input to domain representation
        let domainTransactionRequest = request.domainTransactionRequest
        
        // adapt external interfaces
        let domainPaymentService = RemotePaymentServiceAdapter(externalRemotePaymentService: paymentService)
        let domainCompletionDelegate = PaymentCompletionDelegateAdapter(externalCompletionDelegate: completionDelegate)
        
        // execute service
        self.internalPaymentManager.startApplePayTransaction(
            withRequest: domainTransactionRequest,
            paymentService: domainPaymentService,
            completion: domainCompletionDelegate.domainPaymentCompletion(_:)
        )
    }
}
