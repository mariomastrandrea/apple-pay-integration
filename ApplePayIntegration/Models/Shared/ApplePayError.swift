//
//  ApplePayError.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

enum ApplePayError : Error {
    /// Apple Pay services are not available in user's device
    case applePayNotAvailable
    /// A generic error occurred during Apple Pay payment flow
    case genericError
    /// Some format error is present in the request, most likely in the Price Items
    case badFormattedTransactionRequest
    /// The transaction request object is not configured properly: some fields are missing or bad configured
    case badConfiguredTransactionRequest
    /// Some error occurred during the remote payment process
    case failedRemoteTransactionProcessing
    /// The user canceled the payment operation dismissing the payment sheet
    case userCanceledPayment

    
    var localizedDescription: String {
        switch self {
            case .applePayNotAvailable:
                return "Apple Pay services are not available in user's device"
            case .genericError:
                return "A generic error occurred during Apple Pay payment flow"
            case .badFormattedTransactionRequest:
                return "Apple Pay Transaction Request is not formatted correctly"
            case .badConfiguredTransactionRequest:
                return "Apple Pay Transaction Request is not properly configured: some fields are missing or bad configured"
            case .failedRemoteTransactionProcessing:
                return "Apple Pay transaction processing failed"
            case .userCanceledPayment:
                return "User canceled Apple Pay transaction operation"
        }
    }
}
