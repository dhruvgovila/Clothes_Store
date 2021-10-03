//
//  NetworkingRequired.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

// MARK: - Catalogue Networking Required
/// If a component is `CatalogueAPIRequired`, it can access a default `catalogueAPI` lazily.
protocol CatalogueAPIRequired {
    /// `catalogueAPI` is a pure instance of `NetworkingProvider`.
    var catalogueAPI: CatalogueAPIProvider { get }
}

/// This extension provides default implementation of `networkingProvider`.
extension CatalogueAPIRequired {
    /// `catalogueAPI` is pure, and it doesn't preserve states.
    var catalogueAPI: CatalogueAPIProvider {
        DefaultNetworkingProvider()
    }
}

// MARK: - Image Download Networking Required
protocol ImageDownloadRequired {
    /// `imageDownloader` is a pure instance of `NetworkingProvider`.
    var imageDownloader: ImageDownloadProvider { get }
}

/// This extension provides default implementation of `networkingProvider`.
extension ImageDownloadRequired {
    /// `imageDownloader` is pure, and it doesn't preserve states.
    var imageDownloader: ImageDownloadProvider {
        DefaultNetworkingProvider()
    }
}

// MARK: - Cancel API Request Networking Required
protocol CancelAPIRequestRequired {
    /// `apiRequestCanceller` is a pure instance of `NetworkingProvider`.
    var apiRequestCanceller: CancelAPIRequestProvider { get }
}

/// This extension provides default implementation of `networkingProvider`.
extension CancelAPIRequestRequired {
    /// `apiRequestCanceller` is pure, and it doesn't preserve states.
    var apiRequestCanceller: CancelAPIRequestProvider {
        DefaultNetworkingProvider()
    }
}

