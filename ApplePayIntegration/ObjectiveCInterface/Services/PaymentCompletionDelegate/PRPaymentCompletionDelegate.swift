//
//  PRPaymentCompletionDelegate.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Delegate object wrapping the completion handler function, which is asynchronously called when the Apple Pay payment process is completed.
 */
@objc public protocol PRPaymentCompletionDelegate {
    /**
     Called when the Apple Pay flow is completed, either successfully or not.
     */
    func applePayPaymentDidComplete(withResponse transactionResponse: PRTransactionResponse)
}
