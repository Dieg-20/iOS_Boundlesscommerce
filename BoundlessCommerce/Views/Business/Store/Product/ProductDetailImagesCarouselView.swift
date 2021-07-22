//
//  ProductDetailImagesCarouselView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
struct ProductDetailImagesCarouselView: View {
    
    var product: SelectedBusiness.Category.Product
    var aBusiness: Business
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(product.images, id: \.self) { image in
                    ProductDetailCarouselImageView(theImage: image)
                }
            }
           
            .tabViewStyle(PageTabViewStyle())
        }

        .ignoresSafeArea(.all)
    }
}

struct ProductDetailImagesCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailImagesCarouselView(product: SelectedBusiness.Category.Product(id: "", images: [String](), productName: "", productPrice: 0.0, productDescription: "", quantity: 0, productVariants: [SelectedBusiness.Category.Product.Variants]()), aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}
