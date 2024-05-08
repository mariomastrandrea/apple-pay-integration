//
//  PRStubPaymentCompletionDelegate.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 08/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

@objc public class PRStubPaymentCompletionDelegate: NSObject, PRPaymentCompletionDelegate {
    private let handler: (PRTransactionResponse) -> Void
    
    @objc public init(handler: @escaping (PRTransactionResponse) -> Void) {
        self.handler = handler
    }
    
    public func applePayPaymentDidComplete(withResponse transactionResponse: PRTransactionResponse) {
        self.handler(transactionResponse)
    }
}
