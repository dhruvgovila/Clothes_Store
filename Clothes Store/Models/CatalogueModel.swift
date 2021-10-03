//
//  CatalogueModel.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
class CatalogueModel: CatalogueAPIRequired, BasicUtilsRequired {
    
    // Variables
    var products : [Product] = []
    var selectedProduct: Product!
    
    // Functions
    
    /// Function to get product from API Call
    /// - Parameter completion: Closure to know if the product was added successfully
    func getProducts(completion: @escaping (Bool) -> Void) {
        catalogueAPI.getProductsCatalogue {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.products = response.products ?? []
                completion(true)
            case let .failure(error):
                print(error.rawValue)
                self.basicUtils.showAlertController(title: Alert.errorTitle,
                                                    message: error.rawValue,
                                                    actionDetails:[(title: Alert.retry, action: {[weak self] _ in
                    guard let self = self else { return }
                    self.getProducts(completion: completion)
                })])
                completion(false)
            }
        }
    }
    
    /// Function to get model for Detail Screen
    /// - Returns: `DetailsScreenModel` object
    func getProductDetailModel() -> DetailsScreenModel {
        if selectedProduct != nil {
            return DetailsScreenModel(product: selectedProduct)
        } else {
            return DetailsScreenModel(product: Product())
        }
    }
}
