//
//  NetworkingProvider+ImageDownload.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit
extension DefaultNetworkingProvider {
    
    /// Function to download images and cache them
    /// - Parameters:
    ///   - model: `ImageDownloadRequestModel` Object
    ///   - completion: Closure to know if the image download succeeded
    func downloadImage(model: ImageDownloadRequestModel,
                       completion: @escaping ((Result<UIImage, NetworkingError>) -> Void)) {
        let requestData = model
        
        //Checking if the image is cached
        if let cachedImage = checkforCachedImage(url: model.url ?? String.blank) {
            completion(.success(cachedImage))
        } else {
            networking.registerNetworkRequest(requestType: .url,
                                              requestData: requestData) { (data, response, error) in
                guard let data = data else {
                    return completion(.failure(.responseFailed))
                }
                cacheImage(url: model.url ?? String.blank, data: data) { image in
                    completion(.success(image))
                }
            }
        }
    }
}

//MARK: Temporary Image Caching
extension DefaultNetworkingProvider {
    
    // Variables
    private var imageCache: NSCache<NSString, AnyObject> {
        return ImageCache.cache
    }
    
    /// Function to check if the image is cached
    /// - Parameter url: `String` Object
    /// - Returns: `UIImage` Object
    private func checkforCachedImage(url: String) -> UIImage? {
        let cachedImage = imageCache.object(forKey: (url as NSString)) as? ImageCache
        return cachedImage?.image
    }
    
    /// Function to contain logic to cache image
    /// - Parameters:
    ///   - url: String` Object
    ///   - data: `Data` Object
    ///   - completion: Closure to know if the cache was successful
    private func cacheImage(url: String,
                            data: Data,
                            completion: @escaping (UIImage) -> Void) {
        DispatchQueue.main.async {
            let cacheImage = ImageCache()
            cacheImage.image = UIImage(data: data)
            imageCache.setObject(cacheImage, forKey: (url as NSString))
            if cacheImage.image != nil {
                completion(cacheImage.image)
            }
        }
    }
}

