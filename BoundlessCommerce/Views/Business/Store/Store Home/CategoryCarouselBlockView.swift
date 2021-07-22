//
//  CategoryCarouselBlockView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct CategoryCarouselBlockView: View {
    
    var blockId: String
    var aBusiness: Business
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    @State var updatedImage = UIImage()
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(selectedBusiness.business.categories, id: \.self) { category in
                            NavigationLink (destination: CategoryProductsView(category: category, aBusiness: aBusiness)) {
                                CategoryDisplayView(category: category, aBusiness: aBusiness)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CategoryCarouselBlockView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCarouselBlockView(blockId: "", aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}
