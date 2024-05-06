//
//  ApplePayPayment+CardType.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    /**
     Possible payment card types available on Apple Pay. They refer to the PassKit `PKPaymentMethodType` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkpaymentmethodtype).
     */
    enum CardType: Codable {
        case unknown
        case debit
        case eMoney
        case credit
        case prepaid
        case store
        
        static func from(passkitType: PKPaymentMethodType) -> Self {
            switch passkitType {
                case .debit:    return .debit
                case .eMoney:   return .eMoney
                case .credit:   return .credit
                case .prepaid:  return .prepaid
                case .store:    return .store
                default:        return .unknown
            }
        }
    }
}
