//
//  AppView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFirestore

struct AppView: View {
    
    @EnvironmentObject var businesses: Businesses
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            TabView {
                AppHomeView()
                    .onAppear(perform: {
                        if businesses.businesses.count == 0 {
                            fetchBusinessesIdentifiers()
                        }
                        selectedBusiness.storeTheme.mainColor = "000000"
                    })
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                FavoriteBusinessListView()
                    .tabItem {
                        Label("Favorites", systemImage: "suit.heart")
                    }
                }
                .accentColor(Color(UIColor(selectedBusiness.storeTheme.mainColor ?? "000000") ?? UIColor(.black)))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            }
        
    }
    
    
    func fetchBusinessesIdentifiers() {

        db.collection("Users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            

            self.businesses.businesses = documents.compactMap { (queryDocumentSnapshot) -> Business? in
                return try? queryDocumentSnapshot.data(as: Business.self)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
