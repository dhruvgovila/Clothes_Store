//
//  CatalogueAPIRequestModel.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// Catalogue API Model
struct CatalogueAPIRequestModel: NetworkRequestParams {
    
    // Variables
    var method: HttpMethods?
    var queryParams: [URLQueryItem]?
    var requestBody: Data?
    var url: String? = NetworkConfig.URLs.base + NetworkConfig.URLs.catalogue
}
