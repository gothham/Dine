//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Restaurant {
    private var name: String
    private var restaurantId: UUID
    private var location: String
    
    var menu: Menu
    
    init(name: String, location: String, menu: Menu) {
        self.name = name
        self.restaurantId = UUID()
        self.location = location
        self.menu = menu
    }
    
    /// Create instance of `Restaurant` with default `Menu`.
    /// - SeeAlso: Convenience init of `Menu`.
    convenience init(name: String, location: String) {
        self.init(name: name, location: location, menu: Menu())
    }
    
}
