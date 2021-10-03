//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class BasketViewController: UIViewController {
    
    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    //Variables
    var model = CartListScreenModel()
    
    enum Constants {
        static let removeCell = "Remove"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    // MARK: - Functions
    
    /// Function to Update UI and load/re-load View data
    private func updateUI() {
        total.text = CurrencyHelper.getMoneyString(model.getTotalPrice())
        noProductsLabel.isHidden = model.shouldHideNoProductsLabel()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: Constants.removeCell, handler: {[weak self] (action, view, completion) in
            guard let self = self else { return }
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
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketViewTableViewCell.self), for: indexPath) as? BasketViewTableViewCell {
            cell.configureWithProduct(product: model.products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
