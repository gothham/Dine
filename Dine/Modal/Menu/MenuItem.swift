//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuItem: Codable {
    let itemId: UUID
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.itemId = UUID()
        self.name = name
        self.price = price
    }
}

extension MenuItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemId)
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}
