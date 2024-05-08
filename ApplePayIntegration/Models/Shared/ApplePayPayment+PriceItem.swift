//
//  ApplePayPayment+PriceItem.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    struct PriceItem {
        let label: String    // (required)
        let price: String    // (required, format XX.XX)
        
        var passkitSummaryItem: PKPaymentSummaryItem? {
            guard let price = Decimal(string: price) else { return nil }
            
            return PKPaymentSummaryItem(
                label: label,
                amount: NSDecimalNumber(decimal: price),
                type: .final
            )
        }
    }
}
