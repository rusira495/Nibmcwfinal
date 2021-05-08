//
//  CartHandler.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/8/21.
//

import Foundation

class CartHandler {
    
    static var FoodItems: [fooditem] = []
    
    static func getCartItems() -> [fooditem] {
        return FoodItems
    }
    
    static func clearCart() {
        self.FoodItems.removeAll()
    }
    
}
