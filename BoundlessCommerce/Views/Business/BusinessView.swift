//
//  BusinessView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFunctions

struct BusinessView: View {
    @EnvironmentObject var selectedBusiness: theSelectedBusiness
    let db = Firestore.firestore()
    let functions = Functions.functions()
    
    var businessId: String
    var businessName: String
    var aBusiness: Business
    
    var body: some View {
        VStack {
            BusinessHomeView(aBusiness: aBusiness, businessId: businessId)
                .onAppear(perform: {
                    fetchBusinessCategories()
                    fetchBusinessStoreStructure()
                    arrangeBusinessNameAndId()
                    fetchClientToken()
                    fetchStoreTheme()
                })
        }

    }
    
    func arrangeBusinessNameAndId() {
        selectedBusiness.business.id = businessId
        selectedBusiness.business.name = businessName
    }
    
func fetchClientToken() {
    if selectedBusiness.businessAppClientToken == "none" {
        functions.httpsCallable("createAppClientToken").call(["merchantAccountId" : businessId]) { (result, error) in
            if let error = error as NSError? {
                print("Unable to generate app client token:", error)
            } else {
                if let data = (result?.data as? [String: String]) {
                    print("DATA:", data)
                    selectedBusiness.businessAppClientToken = data["appClientToken"] ?? ""
                } else {
                    print("Unable to convert data", error)
                    print(result)
                }
            }
        }
    }
    }
    
    
    func fetchBusinessCategories() {
        if selectedBusiness.business.categories.count == 0 {
        db.collection("Users").document(aBusiness.id ?? "").collection("Categories").getDocuments() { (querySnapshot, err) in
            if let err = err{
                print("Unable to get categories", err)
            } else {
                for categoryDocument in querySnapshot!.documents {
                    do {
                        let category = try categoryDocument.data(as: SelectedBusiness.Category.self)
                        selectedBusiness.business.categories.append(category ?? SelectedBusiness.Category(id: "", categoryName: "", hasImage: false, categoryChecked: false, categoryProducts: [SelectedBusiness.Category.Product]()))
                        print("category succesfully converted")
                        
                        
                        db.collection("Users").document(aBusiness.id ?? "" ).collection("Categories").document(categoryDocument.documentID).collection("Products").getDocuments() { (querySnapshot, err) in
                            if let err = err{
                                print("Unable to get categories", err)
                            } else {
                                for productDocument in querySnapshot!.documents {
                                    do {
                                        let product = try productDocument.data(as:SelectedBusiness.Category.Product.self)
                                        for categoryIdx in selectedBusiness.business.categories.indices {
                                            if selectedBusiness.business.categories[categoryIdx].id == categoryDocument.documentID {
                                                print("!!!!!!!!! FETCHED PRODUCT ID:", product!.id)
                                                selectedBusiness.business.categories[categoryIdx].categoryProducts.append(product!)
                                            }
                                        }
                                    }
                                    catch {
                                        print("Unable to convert to type Product", error)
                                    }
                                }
                            }
                        }
                        
                
                    }
                    catch {
                        print("Unable to convert to type Category", error)
                    }
                    
                   
                    
                }
            }
        }
        }
    }
    
    func fetchStoreTheme() {
        db.collection("Users").document(aBusiness.id ?? "").collection("StoreTheme").document("Colors").getDocument { (document, error) in
            guard let document = document else {return}
            do {
                self.selectedBusiness.storeTheme = try document.data(as: SelectedBusiness.StoreTheme.self) ?? selectedBusiness.storeTheme
            }
            catch{
                print("error")
            }
        
        }
    }

    
    func fetchBusinessStoreStructure() {
        if selectedBusiness.storeHomeStructure.blocks.count == 0 {
            db.collection("Users").document(businessId).collection("StoreStructure").order(by: "position").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no documents")
                    return
                }
                
                print("block documents:", documents.count)
                
                self.selectedBusiness.storeHomeStructure.blocks = documents.compactMap { (queryDocumentSnapshot) -> SelectedBusiness.StoreHomeStructure.Block? in
                    return try? queryDocumentSnapshot.data(as: SelectedBusiness.StoreHomeStructure.Block.self)
                }
            }
        }
        }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(businessId: "", businessName: "", aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}
