//
//  CardView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import Stripe

struct CardView: View {
    
    @ObservedObject var model = StripeBackendModel()
    @State var loading = false
    @State var paymentMethodParams: STPPaymentMethodParams?
    
    var body: some View {
        VStack {
            STPPaymentCardTextField
                .Representable(paymentMethodParams: $paymentMethodParams).padding()
            
            if let paymentIntent = model.paymentIntentParams {
                Button(action: {
                    paymentIntent.paymentMethodParams = paymentMethodParams
                    loading = true
                }) {
                    Text("Buy")
                }
                .paymentConfirmationSheet(isConfirmingPayment: $loading, paymentIntentParams: paymentIntent, onCompletion: model.onCompletion)
                .disabled(loading)
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: {
            model.preparePaymentIntent(paymentMethodType: "card", currency: "usd")
        })
        
        if let paymentStatus = model.paymentStatus {
            HStack {
                switch paymentStatus {
                case .succeeded:
                    Text("Payment complete")
                case .failed:
                    Text("Payment failed")
                case .canceled:
                    Text("Payment canceled")
                @unknown default:
                    Text("Unkown")
                }
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
