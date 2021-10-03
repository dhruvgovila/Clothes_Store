//
//  NetworkingProvider+Catalogue.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
extension DefaultNetworkingProvider {
    
    /// Function to make `GET` Catalogue Details
    /// - Parameter completion: Closure to know the status of API response
    func getProductsCatalogue(completion: @escaping ((Result<Products, NetworkingError>) -> Void)) {
        let requestData = CatalogueAPIRequestModel()
        networking.registerNetworkRequest(requestType: .urlRequest,
                                          requestData: requestData) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(.responseFailed))
            }
            guard let decodedResponse = try? JSONDecoder().decode(Products.self, from: data) else {
                return completion(.failure(.parsingFailed))
            }
            completion(.success(decodedResponse))
        }
    }
}
