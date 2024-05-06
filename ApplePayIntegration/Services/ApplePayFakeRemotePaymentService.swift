//
//  ApplePayFakeRemotePaymentService.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 06/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

extension ApplePayPayment {
    class ApplePayFakeRemotePaymentService: ApplePayRemotePaymentService {
        var count: Int = 0
        
        func processPayment(withInfo paymentInfo: ApplePayPayment.PaymentInfo) -> Result<Void, RemotePaymentError> {
            print("- Performing payment with info:\n\(paymentInfo.jsonString)")
            
            let result: Result<Void, RemotePaymentError>
            
            if self.count % 2 == 0 {
                result = .success(())
            }
            else {
                result = .failure(.init())
            }
            
            count += 1
            return result
        }
    }
}

extension Encodable {
    var jsonString: String {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .base64
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self) else { return "" }
        
        return String(data: data, encoding: .utf8) ?? ""
    }
}
