//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit
import SwiftUI

class DetailViewContainerViewController: UIViewController{

    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var model : DetailsScreenModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtons()
    }
    
    /// Function to setup buttons
    private func setUpButtons(){
        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Seque.productDetailTableViewController {
            let dest = segue.destination as! ProductDetailTableViewController
            dest.model = ProductDetailsModel(product: model?.product ?? Product())
        }
    }


    // MARK: - Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        model?.addProductToCartList { [weak self] success in
            if success {
                guard let self = self else { return }
                self.dismiss(animated: true, completion: nil)
            }
        }
        Haptic.feedBack()
    }
    
    @IBAction func addToWishListAction(_ sender: Any) {
        model?.addProductToWishList {[weak self] success in
            if success {
                guard let self = self else { return }
                self.dismiss(animated: true, completion: nil)
            }
        }
        Haptic.feedBack()
    }
}


/// Struct to make this screen `UIViewControllerRepresentable`
/// This would help in configuring this screen to launch from SwiftUI Screen
struct DetailsScreen: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    let model: DetailsScreenModel
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let storyboard = UIStoryboard(name: Storyboard.main, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: ViewController.detailViewContainerViewController) as? DetailViewContainerViewController {
            let navigationController = UINavigationController(rootViewController: detailVC)
            detailVC.model = model
            return navigationController
        }
        return UINavigationController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}
