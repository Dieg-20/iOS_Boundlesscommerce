//
//  ProductCarouselBlockView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
struct ProductCarouselBlockView: View {
    
    var blockId: String
    var aBusiness: Business
    var selectedCategoryId: String
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            ZStack {
                Divider()
                ScrollView(.horizontal) {
                    HStack() {
                        ForEach(selectedBusiness.business.categories, id: \.self) { category in
                            if category.id == selectedCategoryId {
                                ForEach(category.categoryProducts, id: \.self) { product in
                                    NavigationLink(destination: ProductDetailView(currentCategory: category, product: product, aBusiness: aBusiness)) {
                                        ProductDisplayViewForProductCarouselBlockView(product: product)
                                    }
                                }
                            }
                        }
//                        .frame( height: screenHeight/3)
                    }
                }
                
                .background(Color.white)
            }
        }
        .padding()
    }
}

struct ProductCarouselBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarouselBlockView(blockId: "", aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false), selectedCategoryId: "")
    }
}
