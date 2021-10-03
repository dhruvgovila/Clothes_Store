//
//  File.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// Model to Manage Wish List Screen Controller
struct WishListScreenModel: ShoppingActivityRequired, BasicUtilsRequired {
    
    // Variables
    var products: [Product] {
        get {
            return shoppingActivity.wishlistModel.products
        }
    }
    
    //MARK: Functions
    
    /// Function to know if the No Product Label should be shown
    /// - Returns: `Bool` Object
    func shouldHideNoProductsLabel() -> Bool {
        return !products.isEmpty
    }
    
    /// Function contaninng logic to add product to cart
    /// - Parameters:
    ///   - product: `Product` object
    ///   - completion: Completion to know if the addition succeeded
    func addProductToCart(product: Product, completion: @escaping (Bool) -> Void) {
        let result = shoppingActivity.cartListmodel.addProduct(product: product)
        switch result {
        case .success:
            shoppingActivity.wishlistModel.removeProduct(product: product)
            basicUtils.showAlertController(title: Alert.successTitle,
                                           message: Alert.messageCartAdd,
                                           actionDetails:[(title: Alert.buttonOk, action: { _ in
                completion(true)
            })])
        case let .failure(error):
            basicUtils.showAlertController(title: Alert.errorTitle,
                                           message: error.rawValue,
                                           actionDetails:[(title: Alert.buttonOk, action: { _ in
                completion(false)
            })])
        }
    }
    
    /// Function to remove project
    /// - Parameter index: `Int` Object
    func removeProducts(index: Int) {
        shoppingActivity.wishlistModel.removeProduct(index: index)
    }
}
