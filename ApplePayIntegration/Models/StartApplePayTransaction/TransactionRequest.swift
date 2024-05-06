//
//  TransactionRequest.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    struct TransactionRequest {
        let totalPrice: PriceItem                       // (required)
        let priceItems: [PriceItem]?                    // (no required)
        let merchantId: String                          // (required, same MerchantID of the ApplePay entitlement)
        let merchantCapabilities: [MerchantCapability]  // (required, at least one between 3DS and EMV)
        let countryCode: String                         // (required, two-letter ISO 3166 code)
        let currencyCode: String                        // (required, three-letter ISO 4217 currency code)
        let possiblePaymentMethods: [PaymentMethod]     // (Required, at least one)
        
        init(totalPrice: PriceItem, priceItems: [PriceItem]? = nil, merchantId: String, merchantCapabilities: [MerchantCapability], countryCode: String, currencyCode: String, possiblePaymentMethods: [PaymentMethod]) {
            self.totalPrice = totalPrice
            self.priceItems = priceItems
            self.merchantId = merchantId
            self.merchantCapabilities = merchantCapabilities
            self.countryCode = countryCode
            self.currencyCode = currencyCode
            self.possiblePaymentMethods = possiblePaymentMethods
        }
        
        var passkitPaymentRequest: PKPaymentRequest? {
            let request = PKPaymentRequest()
            
            // add price
            request.paymentSummaryItems = self.getPasskitPriceItems()
            guard request.paymentSummaryItems.count > 0 else {
                // price information not correct or missing
                return nil
            }
            
            request.merchantIdentifier = self.merchantId
            request.merchantCapabilities = PKMerchantCapability(
                self.merchantCapabilities.map(\.passkitMerchantCapability)
            )
            
            request.countryCode = self.countryCode
            request.currencyCode = self.currencyCode
            request.supportedNetworks = self.possiblePaymentMethods.map(\.passkitPaymentNetwork)
            
            return request
        }
        
        private func getPasskitPriceItems() -> [PKPaymentSummaryItem] {
            var items = [PKPaymentSummaryItem]()
            
            // add subprice information, if any
            if let priceItems, !priceItems.isEmpty {
                let passkitItems = priceItems.compactMap(\.passkitSummaryItem)
                items.append(contentsOf: passkitItems)
                
                if passkitItems.count != priceItems.count {
                    let unrecognizedItems = priceItems.filter { $0.passkitSummaryItem == nil }
                    print("Error: some unrecognized price items due to uncorrect price format\n\(unrecognizedItems)")
                }
            }
            
            // add total price
            guard let passkitTotalPrice = totalPrice.passkitSummaryItem else {
                print("Error: total price format is not correct for PKPaymentRequest\n(\(totalPrice))")
                return []
            }
            
            items.append(passkitTotalPrice)
            return items
        }
    }
}

