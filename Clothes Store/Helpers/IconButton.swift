//
//  IconButton.swift
//  Clothes Store
//
//  Created by dgovila on 02/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

@IBDesignable
class IconButton: UIButton {
    @IBInspectable var pointSize:CGFloat = 30.0

    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: pointSize)
            setPreferredSymbolConfiguration(config, forImageIn: .normal)
        } else {
            // Fallback on earlier versions
        }
    }
}
