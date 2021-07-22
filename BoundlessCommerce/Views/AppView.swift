//
//  AppView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFunctions

struct AppView: View {
    
    @EnvironmentObject var businesses: Businesses
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    let functions = Functions.functions()
    
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
        functions.httpsCallable("fetchBusinessesIdentifiers").call() { (result, error) in
            if let error = error as NSError? {
                print("Unable to get businesses identifiers")
            } else {
                print(result?.data)
                
                let decoder = JSONDecoder()
                
                let JSONresponse = """
                    \(result!.data)
                    """
                let jsonData = Data(JSONresponse.utf8)
                
                do {
                    let allBusinesses = try decoder.decode(BusinessesJSONresponse.self, from: jsonData)
                    print("BUSINESSES:", businesses)
                    businesses.businesses = allBusinesses.businessDocs
                } catch {
                    print(error)
                }
                
                
            }
        }
    }
    
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
