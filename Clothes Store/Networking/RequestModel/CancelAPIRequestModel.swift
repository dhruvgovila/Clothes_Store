//
//  CancelAPIRequest.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

// Model to manage data for API Cancellation
struct CancelAPIRequestModel: NetworkRequestParams {
    
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
