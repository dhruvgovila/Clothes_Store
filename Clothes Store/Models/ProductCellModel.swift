//
//  ProductCell.swift
//  Clothes Store
//
//  Created by dgovila on 01/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import SwiftUI

/// Model to manager Product Cell
struct ProductCellModel {
    
    // Variables
    var product: Product
    var didSelectProductClosure: ((_ product: Product) -> Void)?
}

struct ProductPictureModel: ImageDownloadRequired {
    
    // Variables
    var imagePath: String
    
    /// Function to download the image
    /// - Parameter completion: Closure to get the downloaded image
    func downloadImage(completion: @escaping (Image) -> Void) {
        var downloadedImage: Image = Image(ImageName.placeHolderImage)
        imageDownloader.downloadImage(model: ImageDownloadRequestModel(url: imagePath)) { result in
            switch result {
            case let .success(image):
                downloadedImage = Image(uiImage: image)
            case let .failure(error):
                print(error.rawValue)
            }
            completion(downloadedImage)
        }
    }
}
