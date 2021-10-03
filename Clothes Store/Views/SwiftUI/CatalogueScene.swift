//
//  CatalogueScene.swift
//  Clothes Store
//
//  Created by dgovila on 30/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

struct CatalogueScene: View {
    
    //Variables
    let model = CatalogueModel()
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var products : [Product] = []
    @State var shouldPresentProductDetailsScreen: Bool = false
    
    /// Body to determine Current Screen main view
    var body: some View {
        if products.isEmpty {
            currentView
        } else {
            completeBody
        }
    }
    
    /// Function to determine current main view
    /// - Returns: `View` object
    private var currentView: some View {
        return VStack {
            CustomProgressView()
        }.onAppear {
            getProducts()
        }
    }
    
    /// Function to complete body after loading data from api
    /// - Returns: `View` object
    private var completeBody: some View {
        ZStack {
            ScrollView {
                Spacer(minLength: 20)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products, id: \.self) { product in
                        ProductCell(model: ProductCellModel(product: product) { selectedProduct in
                            model.selectedProduct = product
                            shouldPresentProductDetailsScreen = true
                            Haptic.feedBack()
                        })
                    }
                }
                .padding(.horizontal)
                Spacer(minLength: 20)
            }
        }
        .background(Color(.systemGray6))
        .sheet(isPresented: $shouldPresentProductDetailsScreen, onDismiss: {
            shouldPresentProductDetailsScreen = false
        }, content: {
            DetailsScreen(model: model.getProductDetailModel())
        })
    }
    
    /// Function to get Products from api call
    private func getProducts() {
        model.getProducts { success in
            switch success {
            case true:
                self.products = model.products
            case false:
                break
            }
        }
    }
}

struct CatalogueScene_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueScene()
    }
}

/// Class to configure `CatalogueScene` to load from UIKit
class CatalogueHostingController: UIHostingController<CatalogueScene> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: CatalogueScene());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Catalogue"
    }
}
