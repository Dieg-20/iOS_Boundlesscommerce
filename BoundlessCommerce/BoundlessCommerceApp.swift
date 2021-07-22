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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
