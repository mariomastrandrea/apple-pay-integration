//
//  PaymentCompletionDelegateAdapter.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 08/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

internal class PaymentCompletionDelegateAdapter {
    private let externalCompletionDelegate: PRPaymentCompletionDelegate
    
    init(externalCompletionDelegate: PRPaymentCompletionDelegate) {
        self.externalCompletionDelegate = externalCompletionDelegate
    }
    
    func domainPaymentCompletion(
        _ paymentResult: Result<ApplePayPayment.TransactionResponse, ApplePayError>
    ) -> Void {
        // map output to external representation
        let externalTransactionResponse = PRTransactionResponse(from: paymentResult)
        
        self.externalCompletionDelegate.applePayPaymentDidComplete(withResponse: externalTransactionResponse)
    }
}
