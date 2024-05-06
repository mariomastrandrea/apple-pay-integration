//
//  PaymentInfo.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    /**
     Object containing all the payment information gathered by Apple Pay and needed to process the transaction
     */
    struct PaymentInfo: Codable {
        /// A unique identifier for this transaction
        let id: String
        /// Contains the encrypted payment data
        let paymentToken: Data
        /// Type of circuit used for the transaction
        let paymentMethod: PaymentMethod?
        
        let cardType: CardType?
        
        init(passkitPaymentInfo: PKPayment) {
            self.id = passkitPaymentInfo.token.transactionIdentifier
            self.paymentToken = passkitPaymentInfo.token.paymentData
            self.paymentMethod = PaymentMethod.from(
                passkitPaymentNetwork: passkitPaymentInfo.token.paymentMethod.network
            )
            self.cardType = CardType.from(
                passkitType: passkitPaymentInfo.token.paymentMethod.type
            )
        }
    }
}
