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
     Object containing all the payment information needed to process the transaction.
     */
    struct PaymentInfo: Codable {
        /// A unique identifier for this transaction.
        let id: String
        /**
         Contains the encrypted payment data as a UTF-8 encoded serialization of a JSON dictionary, according to Apple Pay guidelines.
         
         Send this data to your e-commerce back-end system, where it can be decrypted and submitted to your payment processor.
         
         For the format of the payment data, see [Payment Token Format Reference](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/apple_pay/payment_token_format_reference#//apple_ref/doc/uid/TP40014929).
         */
        let paymentToken: Data
        /// Type of circuit used for the transaction.
        let paymentMethod: PaymentMethod?
        /// Type of card used for the trandaction (es. debit, credit, etc.).
        let cardType: CardType?
        
        internal init(passkitPaymentInfo: PKPayment) {
            self.id = passkitPaymentInfo.token.transactionIdentifier
            self.paymentToken = passkitPaymentInfo.token.paymentData
            self.paymentMethod = PaymentMethod.from(
                passkitPaymentNetwork: passkitPaymentInfo.token.paymentMethod.network
            )
            self.cardType = CardType.from(
                passkitType: passkitPaymentInfo.token.paymentMethod.type
            )
        }
        
        internal init(id: String, paymentToken: Data, paymentMethod: PaymentMethod?, cardType: CardType?) {
            self.id = id
            self.paymentToken = paymentToken
            self.paymentMethod = paymentMethod
            self.cardType = cardType
        }
    }
}
