//
//  NetworkingProvider.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit

/// `NetworkingProvider` Protocol containing Networking Request functions
protocol NetworkingProvider: CatalogueAPIProvider,
                             ImageDownloadProvider,
                             CancelAPIRequestProvider {}

/// `CatalogueAPIProvider` Protocol to contain Catalogue Networking Request functions
/// Currently only one is added but more Catalogue related apis can be added here.
protocol CatalogueAPIProvider {
    func getProductsCatalogue(completion: @escaping ((Result<Products, NetworkingError>) -> Void))
}

/// `ImageDownloadProvider` Protocol to contain Catalogue Networking Request functions
/// Currently only one is added but more ImageDownload related apis can be added here.
protocol ImageDownloadProvider {
    func downloadImage(model: ImageDownloadRequestModel,
                       completion: @escaping ((Result<UIImage, NetworkingError>) -> Void))
}

/// `CancelAPIRequestProvider` Protocol to contain Catalogue Networking Request functions
/// Currently only one is added but more api cancellation related apis can be added here.
protocol CancelAPIRequestProvider {
    func cancelAPIRequest(model: CancelAPIRequestModel)
}

/// Enum Type to handle and provide `NetworkingProvider` function's implementation
enum DefaultNetworkingProvider: NetworkingProvider, Networking {
    case pure
    init() { self = .pure }
}
