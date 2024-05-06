//
//  ApplePayRemotePaymentService.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

struct RemotePaymentError: Error {}

/** Interface of the service acting as mediator between the SDK and the backend Payment Gateway for Apple Pay payments    */
protocol ApplePayRemotePaymentService {
    /**
     Send the payment token information to the remote Payment Gateway and actually perform the payment
     */
    func processPayment(withInfo paymentInfo: ApplePayPayment.PaymentInfo) -> Result<Void, RemotePaymentError>
    #warning("TODO: adjust interface and define if method is sync or async")
}

