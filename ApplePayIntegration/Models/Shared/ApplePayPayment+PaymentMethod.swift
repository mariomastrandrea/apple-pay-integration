//
//  ApplePayPayment+PaymentMethod.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    /**
     Possible payment methods supported by the merchant. They refer to the PassKit `PKPaymentNetwork` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkpaymentnetwork).
     */
    enum PaymentMethod: Codable {
        case amex
        case discover
        case mastercard
        case visa
        
        internal var passkitPaymentNetwork: PKPaymentNetwork {
            switch self {
                case .amex:         return .amex
                case .discover:     return .discover
                case .mastercard:   return .masterCard
                case .visa:         return .visa
            }
        }
        
        internal static func from(passkitPaymentNetwork: PKPaymentNetwork?) -> Self? {
            guard let passkitPaymentNetwork else { return nil }
            
            switch passkitPaymentNetwork {
                case .amex:         return .amex
                case .discover:     return .discover
                case .masterCard:   return .mastercard
                case .visa:         return .visa
                default:            return nil
            }
        }
    }
}
