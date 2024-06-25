//
//  Order.swift
//  CupcakeCorner
//
//  Created by Iphigenie Bera on 4/1/24.
//
import Foundation
import SwiftUI

extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry","Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    
    var hasValidAddress: Bool {
        if name.isEmptyOrWhitespace() || streetAddress.isEmptyOrWhitespace() || city.isEmptyOrWhitespace() || zip.isEmptyOrWhitespace() {
            return false
        }
        return true
    }
    

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                        extraFrosting = false
                        addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    
}
