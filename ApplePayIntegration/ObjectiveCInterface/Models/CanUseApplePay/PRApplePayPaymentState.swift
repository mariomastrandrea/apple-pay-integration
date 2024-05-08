//
//  PRApplePayPaymentState.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/**
 A state indicating the availability of Apple Pay services on the user's device.
 Possible states are: `PRApplePayPaymentState.available`, `PRApplePayPaymentState.notConfiguredPaymentMethods`, `PRApplePayPaymentState.notAvailable`
 */
@objc public class PRApplePayPaymentState: NSObject {
    /** User's device supports Apple Pay */
    @objc public static let available                   = PRApplePayPaymentState(.available)
    /** Device supports Apple Pay, but user has not configured any payment cards related to the specified payment methods */
    @objc public static let notConfiguredPaymentMethods = PRApplePayPaymentState(.notConfiguredPaymentMethods)
    /** User's device does not support Apple Pay due to either hardware limitations or parental controls  */
    @objc public static let notAvailable                = PRApplePayPaymentState(.notAvailable)
    
    private let internalApplePayState: ApplePayPayment.State
    
    internal var domainApplePayState: ApplePayPayment.State {
        return self.internalApplePayState
    }
    
    private init(_ internalApplePayState: ApplePayPayment.State) {
        self.internalApplePayState = internalApplePayState
    }
    
    internal static func from(domainApplePayState: ApplePayPayment.State) -> PRApplePayPaymentState {
        return PRApplePayPaymentState(domainApplePayState)
    }
    
    // MARK: Equatable overrides
    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? PRApplePayPaymentState else { return false }
        return self.internalApplePayState == other.internalApplePayState
    }
    
    override public var hash: Int {
        return self.internalApplePayState.hashValue
    }
    
    // MARK: textual representation
    override public var description: String {
        return self.internalApplePayState.rawValue
    }
}
