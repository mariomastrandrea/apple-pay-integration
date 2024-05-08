//
//  PRMerchantCapability.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Possible payment capabilities supported by the merchant. They refer to the PassKit `PKMerchantCapability` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkmerchantcapability).
 */
@objc public class PRMerchantCapability: NSObject {
    /** Support for the 3-D Secure protocol */
    @objc public static let threeDSecure = PRMerchantCapability(.threeDSecure)
    /** Support for the EMV protocol */
    @objc public static let emv          = PRMerchantCapability(.emv)
    /** Support for credit cards */
    @objc public static let credit       = PRMerchantCapability(.credit)
    /** Support for debit cards */
    @objc public static let debit        = PRMerchantCapability(.debit)
    
    private let internalMerchantCapability: ApplePayPayment.MerchantCapability
    
    internal var domainMerchantCapability: ApplePayPayment.MerchantCapability {
        return self.internalMerchantCapability
    }
    
    private init(_ internalMerchantCapability: ApplePayPayment.MerchantCapability) {
        self.internalMerchantCapability = internalMerchantCapability
    }
    
    internal static func from(domainMerchantCapability: ApplePayPayment.MerchantCapability) -> PRMerchantCapability {
        return PRMerchantCapability(domainMerchantCapability)
    }
    
    // MARK: Equatable overrides
    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? PRMerchantCapability else { return false }
        return self.internalMerchantCapability == other.internalMerchantCapability
    }
    
    override public var hash: Int {
        return self.internalMerchantCapability.hashValue
    }
    
    // MARK: textual representation
    override public var description: String {
        return self.internalMerchantCapability.rawValue
    }
}
