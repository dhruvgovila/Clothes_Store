//
//  NetworkRequestParams.swift
//  Clothes Store
//
//  Created by dgovila on 03/10/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

/// Protocol for default Network request Params
protocol NetworkRequestParams {
    var method: HttpMethods? { get set }
    var requestBody: Data? { get set }
    var url: String? { get set }
    var queryParams: [URLQueryItem]? {get set}
}
