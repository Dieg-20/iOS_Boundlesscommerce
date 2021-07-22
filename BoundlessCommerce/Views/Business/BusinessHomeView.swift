//
//  BusinessHomeView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct BusinessHomeView: View {
    
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    var aBusiness: Business
    var businessId: String
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                ForEach(selectedBusiness.storeHomeStructure.blocks) { block in
                    if block.blockType == "banner" {
                        BannerBlockView(blockId: block.id, businessId: businessId)
                    }
                    if block.blockType == "categoryCarousel" {
                        CategoryCarouselBlockView(blockId: block.id, aBusiness: aBusiness)
                    }
                    if block.blockType == "imageWithText"  {
                        ImageWithTextBlockView(blockId: block.id,  aBusiness: aBusiness, blockText: block.text!)
                    }
                    if block.blockType == "productCarousel"  {
                        ProductCarouselBlockView(blockId: block.id, aBusiness: aBusiness, selectedCategoryId: block.selectedCategory!)
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(false)
        .ignoresSafeArea(.all)
    }
}

struct BusinessHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessHomeView(aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false), businessId: "")
    }
}
