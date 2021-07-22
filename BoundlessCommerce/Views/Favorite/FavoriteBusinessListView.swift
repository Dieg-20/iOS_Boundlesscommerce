//
//  FavoriteBusinessListView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI

struct FavoriteBusinessListView: View {
    @EnvironmentObject var businesses: Businesses
    
    var body: some View {
        List{
            ForEach(businesses.businesses.indices, id: \.self) { businessIdx in
                if businesses.businesses[businessIdx].favorite ?? false {
                    BusinessViewForList(businessIdx: businessIdx)
                }
            }
        }
    }
}

struct FavoriteBusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteBusinessListView()
    }
}
