//
//  RemoteServiceAdapter.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 08/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

internal class RemotePaymentServiceAdapter: ApplePayRemotePaymentService {
    private let externalRemotePaymentService: PRRemotePaymentService
    
    init(externalRemotePaymentService: PRRemotePaymentService) {
        self.externalRemotePaymentService = externalRemotePaymentService
    }
    
    func processPayment(withInfo paymentInfo: ApplePayPayment.PaymentInfo) -> Result<Void, RemotePaymentError> {
        // convert domain representation into external one
        let prPaymentInfo = PRPaymentInfo(from: paymentInfo)
        
        // call remote service
        do {
            try self.externalRemotePaymentService.processPayment(withInfo: prPaymentInfo)
            // payment successfully executed
            return .success(())
        }
        catch {
            // an error occurred processing the payment
            // TODO: map external (generic) error into domain ApplePayError
            return .failure(.init())
        }
    }
}
