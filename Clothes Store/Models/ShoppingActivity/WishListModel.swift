//
//  WishListModel.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

/// To describe error that might comeup while add products to WishList
enum WishListError: String, Error {
    case duplicateProduct = "Product is already added in Wishlist"
    case productInCart = "Product already added in Cart"
}

/// Model class to manage the WishList Activities
class WishListModel {
    // Variables
    let productCount = PassthroughSubject<Int, Never>()
    
    private var _products = [Product]() {
        didSet {
            productCount.send(_products.count)
        }
    }
    
    var products: [Product] {
        get {
            _products
        }
    }
}

//MARK: ShoppingActivityRequired
extension WishListModel: ShoppingActivityRequired {
    
    
    /// Function to add prodect
    /// - Parameters:
    ///   - product: `Product` object
    public func addProduct(product: Product) -> Result<Bool, WishListError> {
        
        // Logic to check if product already exist in wishlist
        for addedProduct in _products {
            if addedProduct == product {
                return .failure(.duplicateProduct)
            }
        }
        
        // Logic to check if the product already exist in cart
        for cartProduct in shoppingActivity.cartListmodel.products {
            if cartProduct == product {
                return .failure(.productInCart)
            }
        }
        
        // Adding the product to wishlist
        _products.append(product)
        return .success(true)
    }
    
    /// Function to remove Product from Wishlist
    /// - Parameter product: `Product` object
    public func removeProduct(product: Product) {
        _products.removeAll(where: {$0 == product})
    }
    
    /// Function to remove Product from Wishlist
    /// - Parameter product: `Int` object
    public func removeProduct(index: Int) {
        _products.remove(at: index)
    }
}
