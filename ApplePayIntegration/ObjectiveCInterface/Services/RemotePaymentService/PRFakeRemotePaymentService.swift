//
//  PRFakeRemotePaymentService.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 08/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

@objc public class PRFakeRemotePaymentService: NSObject, PRRemotePaymentService {
    var count: Int = 0
    
    public func processPayment(withInfo paymentInfo: PRPaymentInfo) throws {
        print("- Performing payment with info:\n\(paymentInfo.jsonString)")
                
        if self.count % 2 == 0 {
            self.count += 1
            return
        }
        else {
            self.count += 1
            throw RemotePaymentError()
        }
    }
}

private extension PRPaymentInfo {
    var jsonString: String {
        return self.domainPaymentInfo.jsonString
    }
}
