//
//  SavedViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class SavedViewTableViewCell: UITableViewCell{

    //Views
    @IBOutlet var cellView: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var addToButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    //Variables
    weak var delegate : BuyCellButtonTapped?
    var product: Product?
    
    /// Function to configure Cells data
    /// - Parameter product: `Product` object
    func configureWithProduct(product: Product){
        self.product = product
        self.productName.text = product.name
        self.productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)
        self.downloadImage()
    }

    @IBAction func addToBasket(_ sender: Any) {
        delegate?.addProductToBasket(self)
    }
}

// MARK: - ImageDownloadRequired
extension SavedViewTableViewCell: ImageDownloadRequired {
    
    /// Function to download image
    func downloadImage() {
        imageDownloader.downloadImage(model: ImageDownloadRequestModel(url: product?.image ?? String.blank)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                self.productImage.image = image
            case let .failure(error):
                print(error.rawValue)
            }
        }
    }
}

// MARK: - CancelAPIRequestRequired
extension SavedViewTableViewCell: CancelAPIRequestRequired {
    
    /// Function to prepare the cell for re-use
    override func prepareForReuse() {
        // Cancelling the download image task
        let model = CancelAPIRequestModel(url: product?.image ?? String.blank)
        apiRequestCanceller.cancelAPIRequest(model: model)
    }
}
