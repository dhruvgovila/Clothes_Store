//
//  CartModel.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import Combine

/// To describe error that might comeup while add products to CartList
enum CartListError: String, Error {
    case outOfStock = "Product is Currently Out of Stock"
    case quantityExeeded = "More of this product is not in stock"
    case appendFailed = "Could not add product to cart"
}

/// Model class to manage the CartList Activities
class CartListModel {
    
    //Variables
    let productCount = PassthroughSubject<Int, Never>()
    
    private var _products = [Product]() {
        didSet {
            calculateAndPublishProductCount()
        }
    }
    
    var products: [Product] {
        get {
            return _products
        }
    }
}

extension CartListModel {
    
    /// Function containing Logic to add product
    /// - Parameter product: `Product` Object
    /// - Returns: `Result` Object
    public func addProduct(product: Product) -> Result<Bool, CartListError> {
        //Checking if product already in CartList
        let filteredProducts = _products.filter({$0.productId == product.productId})
        if filteredProducts.isEmpty {
            
            // Checking if the product is in Stock
            if product.stock == 0 {
                return .failure(.outOfStock)
            }
            
            // Reducing the stock
            product.stock = (product.stock ?? 1) - 1
            _products.append(product)
        } else {
            let filteredProduct = filteredProducts.first
            guard let filteredProduct = filteredProduct else { return .failure(.appendFailed)}
            let newQuantity = (filteredProduct.quantity ?? 1) + 1
            
            // Checking if stock is available to add more counts of the product
            if (filteredProduct.stock ?? 0) == 0 {
                return .failure(.quantityExeeded)
            } else {
                filteredProduct.stock = (filteredProduct.stock ?? 1) - 1
                filteredProduct.quantity = newQuantity
            }
            calculateAndPublishProductCount()
        }
        return .success(true)
    }
    
    fileprivate func calculateAndPublishProductCount() {
        // Calculating total products count
        var count = 0
        for product in _products {
            count += product.quantity ?? 1
        }
        productCount.send(count)
    }
    
    /// Function to remove product from CartList
    /// - Parameter index: `Product` Object
    public func removeProduct(index: Int) {
        let product = _products[index]
        
        //Checking of more than one quantity of same product is added
        if (product.quantity ?? 0) > 1 {
            
            // Reducing the quantity of the product
            product.quantity = (product.quantity ?? 1) - 1
            calculateAndPublishProductCount()
        } else {
            _products.remove(at: index)
        }
        // Increasing the stock
        product.stock = (product.stock ?? 1) + 1
    }
}
