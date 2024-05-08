//
//  PRTransactionResponse.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Contains an error if the Apple Pay payment process did not complete successfully, nothing otherwise.
 */
@objc public class PRTransactionResponse: NSObject {
    @objc public let error: Error?
    #warning("TODO: define relevant info to return")
    
    internal init(from domainTransactionResult: Result<ApplePayPayment.TransactionResponse, ApplePayError>) {
        switch domainTransactionResult {
            case .success(_):
                self.error = nil
                // TODO: fill relevant info
            
            case .failure(let error):
                self.error = error
        }
    }
}
