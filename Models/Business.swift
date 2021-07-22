//
//  Business.swift
//  BoundlessCommerce
//
//  Created by Diego on 7/22/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Business: Identifiable, Decodable, Hashable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var subscribtionActive: Bool
    var merchantActive: Bool
    var favorite: Bool
}

class Businesses: ObservableObject {
    @Published var businesses = [Business]()
}
