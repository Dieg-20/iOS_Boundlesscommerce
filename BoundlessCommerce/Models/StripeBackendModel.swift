//
//  StripeBackendModel.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import Foundation
import Stripe
import FirebaseFunctions

class StripeBackendModel: ObservableObject {
    @Published var paymentStatus: STPPaymentHandlerActionStatus?
    @Published var paymentIntentParams: STPPaymentIntentParams?
    @Published var lastPaymentError: NSError?
    
    var paymentMethodType: String?
    var currency: String?
    
    func preparePaymentIntent(paymentMethodType: String, currency: String) {
        self.paymentMethodType = paymentMethodType
        self.currency = currency
        
        let functions = Functions.functions()
        
        functions.httpsCallable("createStripePaymentIntent").call(["amount": 10000]) { (result, error) in
            if let error = error as NSError? {
                print("Unable to get stripe paymentIntent:", error)
            } else {
                if let data = (result?.data as? [String: String])  {
                    guard let clientSecret = data["clientSecret"] else {return}
                    self.paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
                }
            }
        }
    }
    
    func onCompletion(status: STPPaymentHandlerActionStatus, pi: STPPaymentIntent?, error: NSError?) {
        self.paymentStatus = status
        self.lastPaymentError = error
        
        if status == .succeeded {
            self.paymentIntentParams = nil
            preparePaymentIntent(paymentMethodType: self.paymentMethodType!, currency: self.currency!)
        }
    }
    
}
