//
//  ProductCell.swift
//  Clothes Store
//
//  Created by dgovila on 30/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

struct ProductCell: View {
    
    var model: ProductCellModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color((UIColor.systemBackground)))
            VStack{
                Spacer(minLength: 20)
                ProductPicture(model: ProductPictureModel(imagePath: model.product.image ?? String.blank))
                productName
                Spacer(minLength: 5)
                productPrice
                Spacer(minLength: 20)
            }
        }.onTapGesture {
            model.didSelectProductClosure?(model.product)
        }
    }
    
    /// Product name view
    private var productName: some View {
        HStack {
            Spacer(minLength: 10)
            Text(model.product.name ?? String.blank)
                .font(Font.light)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(.systemGray))
                .lineSpacing(5)
            Spacer(minLength: 10)
        }
    }
    
    /// Product price view
    private var productPrice: some View {
        HStack {
            Spacer(minLength: 10)
            Text(CurrencyHelper.getMoneyString(model.product.price ?? 0))
                .font(Font.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(.systemGray))
                .lineSpacing(5)
            Spacer(minLength: 10)
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(model: ProductCellModel(product: Product(), didSelectProductClosure: nil))
    }
}

struct ProductPicture: View, ImageDownloadRequired {
    
    var model: ProductPictureModel
    @State var imageDownloadedAttempted = false
    @State var downloadedImage = Image(ImageName.placeHolderImage)
    
    init(model: ProductPictureModel) {
        self.model = model
    }
    
    /// Main image body
    var body: some View {
        image
    }
    
    /// Image body
    private var image: some View {
        ZStack {
            downloadedImage
                .resizable()
                .frame(width: 135, height: 170)
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    if imageDownloadedAttempted == false {
                        downloadImage()
                    }
                }
            if imageDownloadedAttempted == false {
                CustomProgressView()
            }
        }
    }
    
    /// Function to download the image
    private func downloadImage() {
        model.downloadImage() { image in
            downloadedImage = image
            imageDownloadedAttempted = true
        }
    }
}
