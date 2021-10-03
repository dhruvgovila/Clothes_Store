//
//  ImageDownloadRequestModel.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//


import Foundation

/// Image Download Details Model
struct ImageDownloadRequestModel: NetworkRequestParams {
    
    // Variables
    var method: HttpMethods?
    var requestBody: Data?
    var url: String?
    var queryParams: [URLQueryItem]?
    
    // Initialisers
    init(url: String) {
        self.url = url
    }
}
