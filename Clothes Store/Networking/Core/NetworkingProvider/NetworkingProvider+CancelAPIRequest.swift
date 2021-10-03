//
//  NetworkingProvider+CancelAPIRequest.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
extension DefaultNetworkingProvider {
    
    /// Function containing logic to cancel the api request
    /// - Parameter model: `CancelAPIRequestModel` Model
    func cancelAPIRequest(model: CancelAPIRequestModel) {
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .filter { $0.originalRequest?.url == URL(string: model.url ?? String.blank) }.first?
                .cancel()
        }
    }
}
