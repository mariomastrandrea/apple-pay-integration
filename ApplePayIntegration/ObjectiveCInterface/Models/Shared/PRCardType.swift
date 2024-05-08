//
//  PRCardType.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 Possible payment card types available on Apple Pay. They refer to the PassKit `PKPaymentMethodType` values, listed [here](https://developer.apple.com/documentation/passkit_apple_pay_and_wallet/pkpaymentmethodtype).
 */
@objc public class PRCardType: NSObject {
    @objc public static let unknown = PRCardType(.unknown)
    @objc public static let debit   = PRCardType(.debit)
    @objc public static let eMoney  = PRCardType(.eMoney)
    @objc public static let credit  = PRCardType(.credit)
    @objc public static let prepaid = PRCardType(.prepaid)
    @objc public static let store   = PRCardType(.store)

    private let internalCardType: ApplePayPayment.CardType
    
    internal var domainCardType: ApplePayPayment.CardType {
        return self.internalCardType
    }
    
    private init(_ internalCardType: ApplePayPayment.CardType) {
        self.internalCardType = internalCardType
    }
    
    internal static func from(domainCardType: ApplePayPayment.CardType?) -> PRCardType? {
        guard let domainCardType else { return nil }
        return PRCardType(domainCardType)
    }
    
    // MARK: Equatable overrides
    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? PRCardType else { return false }
        return self.internalCardType == other.internalCardType
    }
    
    override public var hash: Int {
        return self.internalCardType.hashValue
    }
    
    // MARK: textual representation
    override public var description: String {
        return self.internalCardType.rawValue
    }
}
