//
//  CategoryProductsView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct CategoryProductsView: View {
    
    var category: SelectedBusiness.Category
    var aBusiness: Business
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                ForEach(category.categoryProducts, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(currentCategory: category, product: product, aBusiness: aBusiness)) {
                        CategoryProductDisplayView(product:product)
                    }
                }
            }
        }
    }
}

struct CategoryProductsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryProductsView(category: SelectedBusiness.Category(id: "", categoryName: "", hasImage: false, categoryChecked: false, categoryProducts: [SelectedBusiness.Category.Product]()), aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false) )
    }
}
