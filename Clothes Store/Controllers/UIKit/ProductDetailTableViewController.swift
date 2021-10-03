//
//  ProductDetailTableViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController, ImageDownloadRequired {

    //Views
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productOldPrice: UILabel!
    @IBOutlet var productInStock: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productCategory: UILabel!
    @IBOutlet var productStockCount: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    //Variables
    var model: ProductDetailsModel?
    
    //Constants
    enum Constant {
        static let inStock = "In Stock"
        static let outStock = "Out of Stock"
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Functions
    /// Function to update/setup the UI
    private func updateUI() {
        updateViewsData()
        downloadImage()
    }
    
    /// Function to update the Views Data
    private func updateViewsData() {
        productName.text = model?.product.name ?? String.blank
        productPrice.text = CurrencyHelper.getMoneyString(model?.product.price ?? 0)

        let attributedString = NSMutableAttributedString(string: CurrencyHelper.getMoneyString(model?.product.oldPrice ?? 0))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.primaryColour, range: NSMakeRange(0, attributedString.length))

        if model?.product.oldPrice != nil{
            productOldPrice.attributedText = attributedString
        }

        productCategory.text = model?.product.category?.rawValue
        productStockCount.text = "\(model?.product.stock ?? 0)"
        if (model?.product.stock ?? 0) > 0 {
            productInStock.text = Constant.inStock
        }else{
            productInStock.text = Constant.outStock
        }
    }
    
    
    /// Function to download image
    private func downloadImage() {
        let placeHolderImage = UIImage(named: ImageName.placeHolderImage)
        imageDownloader.downloadImage(model: ImageDownloadRequestModel(url: model?.product.image ?? String.blank)) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                self.productImageView.image = image
            case let .failure(error):
                print("Image download Failed: ", error.rawValue)
                self.productImageView.image = placeHolderImage
            }
        }
    }

    // MARK: - Table view data source & delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 275
        default:
            return 75
        }
    }

}
