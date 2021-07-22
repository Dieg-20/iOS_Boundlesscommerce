//
//  ContentView.swift
//  BoundlessCommerce_AppClip
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFunctions

struct ContentView: View {
    
    @EnvironmentObject var businesses: Businesses
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    
    let functions = Functions.functions()
    
    @State var deepLinkBusinessId: String?
    
    var body: some View {
        NavigationView {
            AllBusinessesList()
                .sheet(item: $deepLinkBusinessId, content: { (id) in
                    Text(id)
                })
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
                .onAppear(perform: {
                    if businesses.businesses.count == 0 {
                        fetchBusinessesIdentifiers()
                    }
                    selectedBusiness.storeTheme.mainColor = "000000"
                })
        }
    }
    private func handleUserActivity(_ userActivity: NSUserActivity){
        guard
            let incomingURL = userActivity.webpageURL,
            let urlComponents = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = urlComponents.queryItems,
            let id = queryItems.first(where: { $0.name == "id" })?.value
        else {
            deepLinkBusinessId = nil
            return
        }
        
        deepLinkBusinessId = String(id)
        
    }
    
    func fetchBusinessesIdentifiers() {
        functions.httpsCallable("fetchBusinessesIdentifiers").call() { (result, error) in
            if let error = error as NSError? {
                print("Unable to get businesses identifiers:", error)
            } else {
                
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

extension String: Identifiable {
    public var id: String {
        self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
