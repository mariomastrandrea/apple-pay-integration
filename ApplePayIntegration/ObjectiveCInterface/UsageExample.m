//
//  UsageExample.m
//  PRNewAppSDK
//
//  Created by Mario Mastrandrea on 08/05/24.
//  Copyright © 2024 Pay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRNewAppSDK/PRNewAppSDK-Swift.h"



@interface TestClass : NSObject

- (void)testMethod;

@end



@implementation TestClass

/*!
 @brief Example of usage of the Apple Pay manager methods
 */
- (void)testMethod {
    ApplePayPaymentManager* manager = [[ApplePayPaymentManager alloc] init];
    
    // canUseApplePay
    
    NSArray* paymentMethods = @[
        PRPaymentMethod.amex,
        PRPaymentMethod.mastercard,
        PRPaymentMethod.visa,
        PRPaymentMethod.discover
    ];
    
    NSArray* merchantCapabilities = @[
        PRMerchantCapability.threeDSecure,
        PRMerchantCapability.emv,
        PRMerchantCapability.credit,
        PRMerchantCapability.debit
    ];
    
    PRApplePayPaymentState* applePayState = [ manager
                canUseApplePayWithPaymentMethods:paymentMethods
                                 andCapabilities:merchantCapabilities
    ];
    
    // startApplePay
    
    PRPriceItem* totalPrice = [[PRPriceItem alloc] initWithLabel:@"Total" price:@"20.99"];
    NSArray* priceItems = @[
        [[PRPriceItem alloc] initWithLabel:@"Item 1" price:@"5.00"],
        [[PRPriceItem alloc] initWithLabel:@"Item 2" price:@"2.99"]
    ];
    NSString* merchantId = @"example.of.merchant.id";
    NSString* countryCode = @"IT";
    NSString* currencyCode = @"EUR";
    
    PRTransactionRequest* transactionRequest = [[PRTransactionRequest alloc] initWithTotalPrice:totalPrice
                                                                                     priceItems:priceItems
                                                                                     merchantId:merchantId
                                                                           merchantCapabilities:merchantCapabilities
                                                                                    countryCode:countryCode
                                                                                   currencyCode:currencyCode
                                                                         possiblePaymentMethods:paymentMethods];
    
    id<PRRemotePaymentService> fakePaymentService = [[PRFakeRemotePaymentService alloc] init];
    
    [manager startApplePayTransactionWithRequest:transactionRequest 
                                  paymentService:fakePaymentService
                              completionDelegate:[[PRStubPaymentCompletionDelegate alloc]
                                                  initWithHandler:^(PRTransactionResponse* transactionResponse){
        if(transactionResponse && transactionResponse.error) {
            printf("An error occurred in Apple Pay flow");
        }
        else {
            printf("Apple Pay flow finished successfully");
        }
    }]];
}

@end
