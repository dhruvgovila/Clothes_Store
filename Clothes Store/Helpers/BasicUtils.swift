//
//  CatalogueAPIRequestModel.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


/// Basic Utilities Protocol
protocol BasicUtilsRequired {
    var basicUtils: BasicUtilsProvider { get }
}

extension BasicUtilsRequired {
    var basicUtils: BasicUtilsProvider {
        return BasicUtils()
    }
}

protocol BasicUtilsProvider {
    func getCurrentControllerOnScreen() -> UIViewController?
    func showAlertController(title: String,
                         message: String,
                         actionDetails: [(title: String,
                                          action: ((UIAlertAction) -> Void)?)]?)
}

/// Struct containing Basic Utility functions
struct BasicUtils: BasicUtilsProvider {
    fileprivate init() {}
    
    /// Function to get the current root view controller
    /// The controller currently on the screen
    /// - Returns: `UIViewController` Object
    func getCurrentControllerOnScreen() -> UIViewController? {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return nil }
        if window.rootViewController?.presentedViewController == nil {
            return window.rootViewController
        } else {
            return window.rootViewController?.presentedViewController
        }
    }
    
    /// Function to show alert on the current root view controller
    /// - Parameters:
    ///   - title: `String` Object
    ///   - message: `String` Object
    ///   - actionDetails: Tuple to contain Alert Actions
    func showAlertController(title: String, message: String, actionDetails: [(title: String, action: ((UIAlertAction) -> Void)?)]?) {
        guard let controller = getCurrentControllerOnScreen() else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actionDetails = actionDetails {
            for actionDetail in actionDetails {
                let alertAction  = UIAlertAction(title: actionDetail.title, style: .default, handler: actionDetail.action)
                alert.addAction(alertAction)
            }
        }
        controller.present(alert, animated: true, completion: nil)
    }
}
