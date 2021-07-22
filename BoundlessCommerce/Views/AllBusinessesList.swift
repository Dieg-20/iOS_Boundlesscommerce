//
//  AllBusinessesList.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct AllBusinessesList: View {
    @EnvironmentObject var businesses: Businesses
    
    var body: some View {
        List{
            ForEach(businesses.businesses.indices, id: \.self) { businessIdx in
                NavigationLink(destination: BusinessView(businessId: businesses.businesses[businessIdx].id ?? "", businessName: businesses.businesses[businessIdx].name, aBusiness: businesses.businesses[businessIdx])) {
                    BusinessViewForList(businessIdx: businessIdx)
                }
            }
        }
    }
}

struct AllBusinessesList_Previews: PreviewProvider {
    static var previews: some View {
        AllBusinessesList()
    }
}
