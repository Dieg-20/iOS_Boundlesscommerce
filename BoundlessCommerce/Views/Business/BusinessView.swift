//
//  BusinessView.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import SwiftUI
import FirebaseFunctions

struct BusinessView: View {
    @EnvironmentObject var selectedBusiness: theSelectedBusiness

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
                    fetchStoreTheme()
                })
        }

    }
    
    func arrangeBusinessNameAndId() {
        selectedBusiness.business.id = businessId
        selectedBusiness.business.name = businessName
    }
    
    
    func fetchBusinessCategories() {
        if selectedBusiness.storeHomeStructure.blocks.count != 0 {
            selectedBusiness.business = SelectedBusiness(id: "", name: "", mainColor: "", productCartButtonColor: "", categories: [SelectedBusiness.Category]())
            
            selectedBusiness.business.id = businessId
            selectedBusiness.business.name = businessName
        }
        functions.httpsCallable("fetchBusinessCategories").call(["merchantAccountId": businessId]) { (result, error) in
            if let error = error as NSError? {
                print("Unable to fetch categories:", error.localizedDescription)
            } else {
                let decoder = JSONDecoder()
                
                let JSONresponse = """
                    \(result!.data)
                    """
                let jsonData = Data(JSONresponse.utf8)
                
                do {
                    let allCategories = try decoder.decode(CategoriesJSONresponse.self, from: jsonData)
                    selectedBusiness.business.categories = allCategories.categoryDocs
                    
                    for categoryIdx in selectedBusiness.business.categories.indices {
                        functions.httpsCallable("fetchCategoryProducts").call(["merchantAccountId": businessId, "categoryId": selectedBusiness.business.categories[categoryIdx].id]) { (result, error) in
                            if let error = error as NSError? {
                                print("Unable to fetch category products:", error.localizedDescription)
                            } else {
                                let decoder = JSONDecoder()
                                
                                let JSONresponse = """
                                    \(result!.data)
                                    """
                                
                                print("JSON RESPONSE:", result!.data )
                                let jsonData = Data(JSONresponse.utf8)
                                
                                do {
                                    let allProductsInCategory = try decoder.decode(CategoryProductsJSONresponse.self, from: jsonData)
                                    selectedBusiness.business.categories[categoryIdx].categoryProducts = allProductsInCategory.productDocs
                                    print("GETS HERE ---------------------------------------")
                                    print(selectedBusiness.business.categories[categoryIdx].categoryProducts)
                                } catch {
                                    print("ERROR________________________")
                                    print(error)
                                    print("ERROR________________________")
                                }
                            }
                        }
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func fetchBusinessStoreStructure() {
        if selectedBusiness.storeHomeStructure.blocks.count != 0 {
            selectedBusiness.storeHomeStructure = SelectedBusiness.StoreHomeStructure(id: "", blocks: [SelectedBusiness.StoreHomeStructure.Block]())
        }
        functions.httpsCallable("fetchBusinessStoreStructure").call(["merchantAccountId": businessId]) { (result, error) in
            if let error = error as NSError? {
                print("Unable to fetch categories:", error.localizedDescription)
            } else {
                let decoder = JSONDecoder()
                
                let JSONresponse = """
                    \(result!.data)
                    """
                let jsonData = Data(JSONresponse.utf8)
                
                do {
                    let allBlocks = try decoder.decode(StoreStructureJSONresponse.self, from: jsonData)
                    selectedBusiness.storeHomeStructure.blocks = allBlocks.storeStructureDocs
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func fetchStoreTheme() {

    }

    

}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(businessId: "", businessName: "", aBusiness: Business(id: "", name: "", subscribtionActive: false, merchantActive: false, favorite: false))
    }
}
