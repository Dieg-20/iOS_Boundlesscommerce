//
//  Business.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import Foundation

struct Business: Identifiable, Decodable, Hashable {
    var id: String
    var name: String
    var subscribtionActive: Bool
    var merchantActive: Bool
    var favorite: Bool
}

struct BusinessesJSONresponse: Decodable {
    var businessDocs: [Business]
}

class Businesses: ObservableObject {
    @Published var businesses = [Business]()
}
