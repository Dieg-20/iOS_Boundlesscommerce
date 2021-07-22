//
//  ContentView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFunctions


struct ContentView: View {
    
    
    var body: some View {
        NavigationView {
            AllBusinessesList()
                .onAppear(perform: {
                    if businesses.businesses.count == 0 {
                        fetchBusinessesIdentifiers()
                    }
                    selectedBusiness.storeTheme.mainColor = "000000"
                })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
