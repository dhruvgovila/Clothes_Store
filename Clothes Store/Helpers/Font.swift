//
//  Font.swift
//  Clothes Store
//
//  Created by dgovila on 30/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import SwiftUI
extension Font {
    
    /// Create a font with the light text style.
    public static var light: Font {
        return Font.custom("HelveticaNeue-Light", size: 14)
    }

    /// Create a font with the bold text style.
    public static var bold: Font {
        return Font.custom("HelveticaNeue-Bold", size: 18)
    }
}
