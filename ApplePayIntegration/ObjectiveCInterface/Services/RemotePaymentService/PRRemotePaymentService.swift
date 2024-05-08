//
//  PRRemotePaymentService.swift
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 07/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

import Foundation

/** Interface of the service acting as mediator between the SDK and the backend Payment Gateway for Apple Pay payments    */
@objc public protocol PRRemotePaymentService {
    /**
     Send the payment token information to the remote Payment Gateway and actually perform the transaction with your backend payment processor.
     */
    func processPayment(withInfo paymentInfo: PRPaymentInfo) throws
    #warning("TODO: adjust interface and define if method is sync or async")
}
