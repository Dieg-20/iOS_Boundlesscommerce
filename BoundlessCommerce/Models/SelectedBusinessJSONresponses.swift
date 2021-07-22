//
//  SelectedBusinessJSONresponses.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import Foundation

struct CategoriesJSONresponse: Decodable {
    var categoryDocs: [SelectedBusiness.Category]
}

struct CategoryProductsJSONresponse: Decodable {
    var productDocs: [SelectedBusiness.Category.Product]
}

struct StoreStructureJSONresponse: Decodable {
    var storeStructureDocs: [SelectedBusiness.StoreHomeStructure.Block]
}
