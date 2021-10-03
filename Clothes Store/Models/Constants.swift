//
//  Constants.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//MARK: Enum Type Safe for String Literals
// Alert Constant
enum Alert {
    static let successTitle = "Message"
    static let errorTitle = "Error"
    static let retry = "Retry"
    static let buttonOk = "Ok"
    
    static let messageWishlistAdd = "Product Added in WishList"
    static let messageCartAdd = "Product Added in Cart"
}

// Image Name Constant
enum ImageName {
    static let placeHolderImage = "placeholderImage"
}

// Storyboard Name Constant
enum Storyboard {
    static let main = "Main"
}

// ViewController Name Constant
enum ViewController {
    static let detailViewContainerViewController = "detailContainer"
}

// Seque Name Constant
enum Seque {
    static let productDetailTableViewController = "detailContainer"
}


// MARK: Color Constants
// UIColor Constants
extension UIColor{
    class var primaryColour: UIColor{
        return #colorLiteral(red: 1, green: 0.3348520994, blue: 0.4051724672, alpha: 1)
    }
}

// Color Constants
extension Color {
    static var primaryColor: Color {
        Color(UIColor.primaryColour)
    }
}

extension String {
    static let blank = ""
}
