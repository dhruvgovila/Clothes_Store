//
//  Manager.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// HttpMethods for API Call Methods
enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
    // Add Other Methods when required
}

/// Enum for NetworkRequestType
enum NetworkRequestType {
    case url
    case urlRequest
}

/// Enum for Networking Error and their String Reasons
enum NetworkingError: String, Error {
    case responseFailed = "Response Failed"
    case parsingFailed = "Response Data Parsing Failed"
}
