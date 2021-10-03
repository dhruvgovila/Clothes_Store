//
//  ImageCache.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit

/// Image Cache Singleton Class
class ImageCache: NSObject {
    
    // Variables
    static let cache = NSCache<NSString, AnyObject>()
    public var image: UIImage!
}

/// Extension of `ImageCache` to contain logic when the app goes in background too
extension ImageCache: NSDiscardableContent {
    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {

    }

    func discardContentIfPossible() {

    }

    func isContentDiscarded() -> Bool {
        return false
    }
}
