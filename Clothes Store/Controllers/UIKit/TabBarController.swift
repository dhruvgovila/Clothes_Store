//
//  TabBarController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//
import UIKit
import Combine

class TabBarController: UITabBarController {

    //Views
    var tabItem : UITabBarItem?
    var wishListProductCount: AnyCancellable?
    var cartListProductCount: AnyCancellable?
    
    //Variables
  
    override func viewDidLoad() {
        super.viewDidLoad()
        observeShoppingActivitiesUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - ShoppingActivityRequired
extension TabBarController: ShoppingActivityRequired {
    
    /// Function to observe changes in WishList and CartList count
    private func observeShoppingActivitiesUpdate() {
        wishListProductCount = shoppingActivity.wishlistModel.productCount.sink {[weak self] count in
            guard let self = self else { return }
            self.tabBar.items?[1].badgeValue = count > 0 ? String(count) : nil
        }
        
        cartListProductCount = shoppingActivity.cartListmodel.productCount.sink {[weak self] count in
            guard let self = self else { return }
            self.tabBar.items?[2].badgeValue = count > 0 ? String(count) : nil
        }
    }
}
