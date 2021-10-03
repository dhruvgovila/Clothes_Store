//
//  Product
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    var products: [Product]?
}

// MARK: - Product
class Product: Codable, Hashable {
    
    var productId, name: String?
    var category: Category?
    var price: Float?
    var stock: Int?
    var oldPrice: Float?
    var image: String?
    lazy var quantity: Int? = {
        return 1
    }()
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productId)
    }
}

enum Category: String, Codable {
    case pants = "Pants"
    case shoes = "Shoes"
    case tops = "Tops"
}

// MARK: - Cart
struct Cart: Codable {
    let cartId, productId: Int?
}



