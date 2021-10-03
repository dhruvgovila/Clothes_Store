//
//  DetailsModel.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// Details Screen Model
/// To manage DetailsScreenViewController
struct DetailsScreenModel {
    let product: Product
}

extension DetailsScreenModel: ShoppingActivityRequired, BasicUtilsRequired {
    
    /// Function having logic to add product to wish list
    /// - Parameter completion: Closure to inmitate success of product addition
    func addProductToWishList(
        completion: @escaping ((Bool) -> Void)
    ) {
        let result = shoppingActivity.wishlistModel.addProduct(product: product)
        switch result {
        case let .success(didAdd):
            basicUtils.showAlertController(title: Alert.successTitle,
                                           message: Alert.messageWishlistAdd,
                                           actionDetails:[(title: Alert.buttonOk, action: { _ in
                completion(didAdd)
            })])
            
        case let .failure(error):
            basicUtils.showAlertController(title: Alert.errorTitle,
                                           message: error.rawValue,
                                           actionDetails: [(title: Alert.buttonOk, action: nil)])
            print(error.rawValue)
        }
    }
    
    /// Function having logic to add product to cart list
    /// - Parameter completion: Closure to inmitate success of product addition
    func addProductToCartList(
        completion: @escaping ((Bool) -> Void)
    ) {
        shoppingActivity.wishlistModel.removeProduct(product: product)
        let result = shoppingActivity.cartListmodel.addProduct(product: product)
        switch result {
        case .success:
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
}
