//
//  ApplePayPayment+MerchantCapability.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment{
    /**
     Possible payment capabilities supported by the merchant. They refer to the PassKit `PKMerchantCapability` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkmerchantcapability).
     */
    enum MerchantCapability: String {
        /** Support for the 3-D Secure protocol */
        case threeDSecure
        /** Support for the EMV protocol */
        case emv
        /** Support for credit cards */
        case credit
        /** Support for debit cards */
        case debit
        
        internal var passkitMerchantCapability: PKMerchantCapability {
            switch self {
                case .threeDSecure: return .threeDSecure
                case .emv:          return .emv
                case .credit:       return .credit
                case .debit:        return .debit
            }
        }
    }
}
