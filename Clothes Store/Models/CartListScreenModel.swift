//
//  CartListScreenModel.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

struct CartListScreenModel: ShoppingActivityRequired {
    // Variables
    var products: [Product] {
        get {
            return shoppingActivity.cartListmodel.products
        }
    }
    
    //MARK: Functions
    
    /// Function to know if the No Product Label should be shown
    /// - Returns: `Bool` Object
    func shouldHideNoProductsLabel() -> Bool {
        return !products.isEmpty
    }
    
    /// Function to get the total price of all the products added
    /// - Returns: `Float` object
    func getTotalPrice() -> Float {
        var total: Float = 0
        for product in products {
            let price = (Float((product.price ?? 0))) * Float(product.quantity ?? 0)
            total += price
        }
        return total
    }
    
    /// Function to remove project
    /// - Parameter index: `Int` Object
    func removeProducts(index: Int) {
        shoppingActivity.cartListmodel.removeProduct(index: index)
    }
}
