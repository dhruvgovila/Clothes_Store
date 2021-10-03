//
//  ShoppingActivityModel.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// Protocol to provide the `ShoppingActivityModel` object
/// This will help in Injecting the Dependency of `ShoppingActivityModel`
protocol ShoppingActivityRequired {
    var shoppingActivity: ShoppingActivityModel { get }
}

extension ShoppingActivityRequired {
    var shoppingActivity: ShoppingActivityModel {
        return ShoppingActivityModel.shoppingActivity
    }
}


/// Class to serve as the Shopping Activity Manager
/// This is a singleton class
class ShoppingActivityModel {
    //Variable
    fileprivate static let shoppingActivity = ShoppingActivityModel()
    
    let wishlistModel = WishListModel()
    let cartListmodel = CartListModel()
    
    // Functions
    // Private initializers
    private init() {}
}
