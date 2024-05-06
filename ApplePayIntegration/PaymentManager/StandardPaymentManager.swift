//
//  StandardPaymentManager.swift
//  Offering-Apple-Pay-in-Your-App
//
//  Created by Mario Mastrandrea on 03/05/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import PassKit

extension ApplePayPayment {
    class StandardPaymentManager: NSObject, ApplePayPaymentManager {
        private var paymentService: ApplePayRemotePaymentService?
        private var paymentCompletion: ApplePayPaymentCompletion?
        
        private static let defaultPaymentResult: Result<TransactionResponse, ApplePayError> = .failure(.userCanceledPayment)
        private var paymentResult = defaultPaymentResult

        
        func canUseApplePay(
            withPaymentMethods paymentMethods: [PaymentMethod],
            andCapabilities capabilities: [MerchantCapability]
        ) -> ApplePayPayment.State {
            if #available(iOS 10.0, *) {
                guard PKPaymentAuthorizationViewController.canMakePayments() else {
                    return .notAvailable
                }
                
                // map input to PassKit types
                let passkitMethods = paymentMethods.map(\.passkitPaymentNetwork)
                let passkitCapabilities = capabilities.map(\.passkitMerchantCapability)
                
                guard PKPaymentAuthorizationViewController.canMakePayments(
                    usingNetworks: passkitMethods,
                    capabilities: PKMerchantCapability(passkitCapabilities)
                )
                else { return .notConfiguredPaymentMethods }
                
                return .available
            }
            else {
                return .notAvailable
            }
        }
        
        func startApplePayTransaction(
            withRequest request: TransactionRequest,
            paymentService: ApplePayRemotePaymentService,
            completion: @escaping ApplePayPaymentCompletion
        ) {
            guard self.canUseApplePay(
                withPaymentMethods: request.possiblePaymentMethods,
                andCapabilities: request.merchantCapabilities
            ) == .available else {
                completion(.failure(.applePayNotAvailable))
                return
            }
            
            if #available(iOS 10.0, *) {
                guard let passkitRequest = request.passkitPaymentRequest else {
                    completion(.failure(.badFormattedTransactionRequest))
                    return
                }
                
                self.paymentService = paymentService
                self.paymentCompletion = completion
                
                // create and present Apple Pay payment sheet
                let passkitPaymentVC = PKPaymentAuthorizationController(paymentRequest: passkitRequest)
                passkitPaymentVC.delegate = self
                passkitPaymentVC.present { presented in
                    if presented {
                        print("Apple Pay payment sheet has been succesfully presented")
                    }
                    else {
                        // Payment request was badly formatted -> payment sheet has not been presented
                        print("Failed to present Apple Pay payment sheet: Transaction Request is badly configured")
                        self.paymentCompletion?(.failure(.badConfiguredTransactionRequest))
                    }
                }
            }
        }
    }
}

// MARK: PKPaymentAuthorizationControllerDelegate
@available(iOS 10.0, *)
extension ApplePayPayment.StandardPaymentManager: PKPaymentAuthorizationControllerDelegate {
    private func internalUserDidAuthorizePayment(_ pkPayment: PKPayment) -> PKPaymentAuthorizationStatus {
        print("* User successfully authorized payment *")
        
        guard let paymentService = self.paymentService else {
            print("Severe error: Payment Service is nil")
            self.paymentResult = .failure(.genericError)
            return .failure
        }
        
        // enclose payment info into domain type
        let paymentInfo = ApplePayPayment.PaymentInfo(passkitPaymentInfo: pkPayment)
        
        // perform transaction *synchronously*
        switch paymentService.processPayment(withInfo: paymentInfo) {
            case .failure(_):
                // some error occurred processing the transaction remotely
                print("Error: remote transaction processing failed")
                self.paymentResult = .failure(.failedRemoteTransactionProcessing)
                return .failure
            
            case .success(_):
                // * payment succeeded *
                self.paymentResult = .success(.init())
                return .success
        }
    }
    
    @available(iOS 10.0, *)
    func paymentAuthorizationController(
        _ controller: PKPaymentAuthorizationController,
        didAuthorizePayment payment: PKPayment,
        completion: @escaping (PKPaymentAuthorizationStatus) -> Void
    ) {
        let paymentStatus = self.internalUserDidAuthorizePayment(payment)
        completion(paymentStatus)
    }
    
    @available(iOS 11.0, *)
    func paymentAuthorizationController(
        _ controller: PKPaymentAuthorizationController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        let paymentStatus = self.internalUserDidAuthorizePayment(payment)
        completion(.init(status: paymentStatus, errors: []))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        print("* Apple Pay payment authorization did finish *")
        let paymentResult = self.paymentResult
        
        controller.dismiss {
            switch paymentResult {
                case .success(_):
                    print("* Apple Pay payment finished with SUCCESS *")
                case .failure(_):
                    print("* Apple Pay payment finished with FAILURE *")
            }
            
            self.paymentResult = Self.defaultPaymentResult
            self.paymentCompletion?(paymentResult)
        }
    }
}



