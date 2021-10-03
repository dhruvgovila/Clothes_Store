//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

/// Protocol to use delegation pattern on `SavedViewTableViewCell`
protocol BuyCellButtonTapped: AnyObject {
    
    /// Function used to indicate that the product can be added to cart from wishlist
    func addProductToBasket(_ sender: SavedViewTableViewCell)
}

class WishlistViewController: UIViewController, BuyCellButtonTapped {

    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!

    //Variables
    var model = WishListScreenModel()
    
    // Constants
    enum Constants {
        static let removeCell = "Remove"
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    // MARK: - Actions
    
    /// Function to add Product to Cart from Wishlist
    /// - Parameter sender: `SavedViewTableViewCell` object
    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        if let product = sender.product {
            model.addProductToCart(product: product) {[weak self] success in
                if success {
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            }
        }
        Haptic.feedBack()
    }
   
    // MARK: - Functions
    /// Function to update/setup the UI
    private func updateUI() {
        tableView.reloadData()
        noProductsLabel.isHidden = model.shouldHideNoProductsLabel()
    }
}

// MARK: - UITableViewDelegate
extension WishlistViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: Constants.removeCell, handler: {[weak self] (_, _, completion) in
            guard let self = self else { return }
            
            // Deleting the product from Wishlist
            self.model.removeProducts(index: indexPath.row)
            self.updateUI()
            completion(true)
            Haptic.feedBack()
        })

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

// MARK: - UITableViewDataSource
extension WishlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SavedViewTableViewCell.self), for: indexPath) as? SavedViewTableViewCell {
            cell.configureWithProduct(product: model.products[indexPath.row])
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}


