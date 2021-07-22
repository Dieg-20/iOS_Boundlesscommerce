//
//  BoundlessCommerceApp.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import Firebase

@main
struct BoundlessCommerceApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var businesses = Businesses()
    var selectedBusiness = theSelectedBusiness()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(businesses)
                .environmentObject(selectedBusiness)
        }
    }
}
