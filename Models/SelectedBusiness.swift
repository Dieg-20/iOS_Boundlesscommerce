//
//  SelectedBusiness.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct SelectedBusiness: Identifiable, Decodable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var mainColor: String?
    var productCartButtonColor: String?
    var categories: [Category]
    
    struct Category: Identifiable, Decodable, Hashable{
        var id: String
        var categoryName: String
        var hasImage: Bool
        var categoryChecked: Bool
        var categoryProducts: [Product]
        
        struct Product: Decodable, Hashable {
            var id: String
            var images: [String]
            var productName: String
            var productPrice: Double
            var productDescription: String
            var quantity: Int
            var productVariants: [Variants]?
            
            struct Variants: Decodable, Hashable {
                var variantId: String
                var variantName: String
                var selectedOption: String
                var selectedVariant: String?
                var variantOptions: [Options]
                
                struct Options: Decodable, Hashable {
                    var optionId: String
                    var optionName: String
                    var optionPrice: Double
                }
            }
        }
    }
    
    struct StoreHomeStructure: Identifiable, Decodable {
        @DocumentID var id: String? = UUID().uuidString
        var blocks: [Block]
        
        struct Block: Identifiable , Decodable, Hashable {
            var id: String
            var blockType: String
            var text: String?
            var selectedCategory: String?
            var position: Int?
        }
    }
    
    struct StoreTheme: Decodable {
        var mainColor: String?
        var productCartButtonColor: String?
    }
    
    struct Order: Identifiable, Decodable{
        var id = UUID()
        var orderProducts: [Category.Product]
        var total: Double
        var orderNumber: Int
        var orderNotes: String
        var orderDate: Date
       
    }
}

class theSelectedBusiness: ObservableObject {
    @Published var business = SelectedBusiness(id: "empty", name: "", categories: [SelectedBusiness.Category]())
    @Published var storeHomeStructure = SelectedBusiness.StoreHomeStructure(id: "", blocks: [SelectedBusiness.StoreHomeStructure.Block]())
    @Published var storeTheme = SelectedBusiness.StoreTheme()
    @Published var order = SelectedBusiness.Order(orderProducts: [SelectedBusiness.Category.Product](), total: 0.0, orderNumber: 0, orderNotes: "", orderDate: Date())
    
    @Published var businessAppClientToken = "none"
    
    @Published var orderTotal = 0.0
    
    func assignSelectedOption() {
        
    }
    
    func recalculatePriceInCart (productPrice: Double, adding: Bool) {
        if(adding) {
            self.order.total = self.order.total   + productPrice
        } else {
            self.order.total  = self.order.total  - productPrice
        }
    }
    
    func recalculatePriceInCart2() {
        var newTotalPrice = 0.0
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        for product in self.order.orderProducts {
            newTotalPrice = newTotalPrice + product.productPrice
        }
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            self.order.total = newTotalPrice
        }
    }
    
    func calculateProductPrice(product: SelectedBusiness.Category.Product, selectedOption: String) {
        let productPrice = product.productPrice
        var selectedOptionsPrices = 0.0
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        if let unwrappedProductVariants = product.productVariants {
            for variant in unwrappedProductVariants {
                for option in variant.variantOptions {
                    if selectedOption == option.optionId {
                        print("EVER GETTING HERE??")
                        selectedOptionsPrices = selectedOptionsPrices + abs(productPrice - option.optionPrice)
                    } else {
                        print("SELECTED AFTER ")
                        print("------------------------")
                        print(selectedOption)
                        print("------------------------")
                    }
                }
            }
        }
        
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            print("PRICE IS BEING CALCULATED")
            let theTotal = productPrice + selectedOptionsPrices
            print(theTotal)
            self.orderTotal = theTotal
            
        }
    }
}
