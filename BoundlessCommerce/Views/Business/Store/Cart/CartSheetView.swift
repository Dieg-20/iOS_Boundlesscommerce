//
//  CartSheetView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct CartSheetView: View {
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var orderTotal = 0.0
    @Environment(\.presentationMode) var presentationMode
    
    @State var nonce = ""
    
    @State var showBraintreeDropIn = false

    var body: some View {

        VStack {
            HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                Text("Back")
            }
            .padding()
                
                Spacer()
            
            Text("Cart")
                .font(.title)
                .fontWeight(.medium)
                
                Spacer()
        }
            
            Spacer()
                List {
                    Section{
                        ForEach(selectedBusiness.order.orderProducts, id: \.self) { orderProduct in
                            ProductDisplayViewCartVersion(orderProduct: orderProduct)
                        }
                        .onDelete(perform: deleteOrderProduct)
                    }
                }
            Text("Total: \(selectedBusiness.order.total, specifier: "%.2f")")
            
           
            ZStack {
 
                NavigationLink(destination: CheckoutView()) {
                    Text("Checkout")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .shadow(radius: 2)
                        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/16, alignment: .center)
                        .background(Color(.black))
                }

            }
        }
            Spacer()
        

        .accentColor(Color(UIColor(selectedBusiness.storeTheme.mainColor ?? "000000") ?? UIColor(.green)))
        
        
        .onAppear(perform: {
            calculateOrderTotal()
        })
    }
    
    func deleteOrderProduct(at offsets: IndexSet) {
        selectedBusiness.order.orderProducts.remove(atOffsets: offsets)
        selectedBusiness.recalculatePriceInCart2()
        
    }
    
    func calculateOrderTotal(){
        
        selectedBusiness.order.total = 0.0
        
        for productIdx in selectedBusiness.order.orderProducts.indices {
            selectedBusiness.order.total += selectedBusiness.order.orderProducts[productIdx].productPrice
        }
    }
}

struct CartSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CartSheetView()
    }
}
