//
//  PRPriceItem.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

@objc public class PRPriceItem: NSObject {
    @objc public let label: String    // (required)
    @objc public let price: String    // (required, format XX.XX)
    
    internal var domainPriceItem: ApplePayPayment.PriceItem {
        return .init(label: self.label, price: self.price)
    }
    
    /**
     Create a new price item for the Apple Pay payment sheet
     - parameter label: (required) The type of price (es. "Total"), or the name of the product/service associated to the price.
     - parameter price: (required) The price amount in the format XX.XX (without currency).
     */
    @objc public init(label: String, price: String) {
        self.label = label
        self.price = price
    }
}
