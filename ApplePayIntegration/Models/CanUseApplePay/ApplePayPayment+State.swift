//
//  ApplePayPayment+State.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

extension ApplePayPayment {
    /**
     A state indicating the availability of Apple Pay services on the user's device.
     */
    enum State: String {
        /** User's device supports Apple Pay. */
        case available
        /** Device supports Apple Pay, but user has not configured any payment cards related to the specified payment methods. */
        case notConfiguredPaymentMethods
        /** User's device does not support Apple Pay due to either hardware limitations or parental controls.  */
        case notAvailable
    }
}
