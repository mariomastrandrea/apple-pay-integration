//
//  PRPaymentMethod.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Possible payment methods supported by the merchant. They refer to the PassKit `PKPaymentNetwork` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkpaymentnetwork).
 */
@objc public class PRPaymentMethod: NSObject {
    @objc public static let amex       = PRPaymentMethod(.amex)
    @objc public static let discover   = PRPaymentMethod(.discover)
    @objc public static let mastercard = PRPaymentMethod(.mastercard)
    @objc public static let visa       = PRPaymentMethod(.visa)
    
    private let internalPaymentMethod: ApplePayPayment.PaymentMethod
    
    internal var domainPaymentMethod: ApplePayPayment.PaymentMethod {
        return self.internalPaymentMethod
    }
    
    private init(_ internalPaymentMethod: ApplePayPayment.PaymentMethod) {
        self.internalPaymentMethod = internalPaymentMethod
    }
    
    internal static func from(domainPaymentMethod: ApplePayPayment.PaymentMethod?) -> PRPaymentMethod? {
        guard let domainPaymentMethod else { return nil }
        return PRPaymentMethod(domainPaymentMethod)
    }
    
    // MARK: Equatable overrides
    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? PRPaymentMethod else { return false }
        return self.internalPaymentMethod == other.internalPaymentMethod
    }
    
    override public var hash: Int {
        return self.internalPaymentMethod.hashValue
    }
    
    // MARK: textual representation
    override public var description: String {
        return self.internalPaymentMethod.rawValue
    }
}
