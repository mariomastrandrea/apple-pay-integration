//
//  PRPaymentInfo.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Object containing all the payment information needed to process the transaction.
 */
@objc public class PRPaymentInfo: NSObject {
    /// A unique identifier for this transaction.
    @objc public let id: String
    /**
     Contains the encrypted payment data as a UTF-8 encoded serialization of a JSON dictionary, according to Apple Pay guidelines.
     
     Send this data to your e-commerce back-end system, where it can be decrypted and submitted to your payment processor.
     
     For the format of the payment data, see [Payment Token Format Reference](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/apple_pay/payment_token_format_reference#//apple_ref/doc/uid/TP40014929).
     */
    @objc public let paymentToken: Data
    /// Type of circuit used for the transaction.
    @objc public let paymentMethod: PRPaymentMethod?
    /// The type of card used for the transaction (es. debit, credit, etc.).
    @objc public let cardType: PRCardType?
    
    internal var domainPaymentInfo: ApplePayPayment.PaymentInfo {
        .init(
            id: self.id,
            paymentToken: self.paymentToken,
            paymentMethod: self.paymentMethod?.domainPaymentMethod,
            cardType: self.cardType?.domainCardType
        )
    }
    
    internal init(from domainPaymentInfo: ApplePayPayment.PaymentInfo) {
        self.id = domainPaymentInfo.id
        self.paymentToken = domainPaymentInfo.paymentToken
        self.paymentMethod = PRPaymentMethod.from(domainPaymentMethod: domainPaymentInfo.paymentMethod)
        self.cardType = PRCardType.from(domainCardType: domainPaymentInfo.cardType)
    }
}
