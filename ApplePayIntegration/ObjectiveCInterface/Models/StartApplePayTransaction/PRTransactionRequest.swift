//
//  PRTransactionRequest.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Object containing all the requested information to start an Apple Pay transaction and generate a payment token.
 */
@objc public class PRTransactionRequest: NSObject {
    @objc public let totalPrice: PRPriceItem                       // (required)
    @objc public let priceItems: [PRPriceItem]?                    // (no required)
    @objc public let merchantId: String                            // (required, same MerchantID of the ApplePay entitlement)
    @objc public let merchantCapabilities: [PRMerchantCapability]  // (required, at least one between 3DS and EMV)
    @objc public let countryCode: String                           // (required, two-letter ISO 3166 code)
    @objc public let currencyCode: String                          // (required, three-letter ISO 4217 currency code)
    @objc public let possiblePaymentMethods: [PRPaymentMethod]     // (Required, at least one)
    
    internal var domainTransactionRequest: ApplePayPayment.TransactionRequest {
        return .init(
            totalPrice: self.totalPrice.domainPriceItem,
            priceItems: self.priceItems?.map(\.domainPriceItem),
            merchantId: self.merchantId,
            merchantCapabilities: self.merchantCapabilities.map(\.domainMerchantCapability),
            countryCode: self.countryCode,
            currencyCode: self.currencyCode,
            possiblePaymentMethods: self.possiblePaymentMethods.map(\.domainPaymentMethod)
        )
    }
    
    /**
     Create a new transaction request object.
     - parameter totalPrice: (required) Total price of the transaction.
     - parameter priceItems: (optional) Subitems' prices of the transaction.
     - parameter merchantId: (required) Same MerchantID of the ApplePay entitlement.
     - parameter merchantCapabilities: (required) Supported capabilities for the transaction: they must contain at least one between 3DS and EMV.
     - parameter countryCode: (required) Two-letter ISO 3166 country code.
     - parameter currencyCode: (required) Three-letter ISO 4217 currency code.
     - parameter possiblePaymentMethods: (required) Supported payment methods for the transaction: must contain at least one value.
     */
    @objc public init(totalPrice: PRPriceItem, priceItems: [PRPriceItem]?, merchantId: String, merchantCapabilities: [PRMerchantCapability], countryCode: String, currencyCode: String, possiblePaymentMethods: [PRPaymentMethod]) {
        self.totalPrice = totalPrice
        self.priceItems = priceItems
        self.merchantId = merchantId
        self.merchantCapabilities = merchantCapabilities
        self.countryCode = countryCode
        self.currencyCode = currencyCode
        self.possiblePaymentMethods = possiblePaymentMethods
    }
}
