//
//  Networking.swift
//  Clothes Store
//
//  Created by dgovila on 29/09/21.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
/// Will be using Dependency Injection to invoke networking
protocol Networking{
    var networking: NetworkingAssociator { get }
}

extension Networking {
    var networking: NetworkingAssociator {
        NetworkingRegister()
    }
}

protocol NetworkingAssociator {
    func registerNetworkRequest(requestType: NetworkRequestType,
                                requestData: NetworkRequestParams,
                                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

/// Type to handle network request
struct NetworkingRegister: NetworkingAssociator {
    
    fileprivate init(){}
    
    let session = URLSession.shared
    
    /// Function to register Network request
    /// - Parameters:
    ///   - requestType: `NetworkRequestType` Object
    ///   - requestData: `NetworkRequestParams` Object
    ///   - completionHandler: Closure to know the status of network request
    public func registerNetworkRequest(requestType: NetworkRequestType,
                                       requestData: NetworkRequestParams,
                                       completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // Adding logic to handle different `NetworkRequestType`
        switch requestType {
        case .url:
            registerURLNetworkRequest(requestData: requestData,
                                      completionHandler: completionHandler)
        case .urlRequest:
            registerURLSessionNetworkRequest(requestData: requestData,
                                             completionHandler: completionHandler)
        }
    }
}

extension NetworkingRegister {
    /// Function to handle URL Network Request
    /// - Parameters:
    ///   - requestData: `NetworkRequestType` Object
    ///   - completionHandler: Closure to know the status of network request
    private func registerURLNetworkRequest(requestData: NetworkRequestParams,
                                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let stringURL = requestData.url,
              let url = URL(string: stringURL) else {
                  return completionHandler(nil, nil, .none)
              }
        let task = session.dataTask(with: url,
                                    completionHandler: { data, response, error in
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        })
        task.resume()
    }
}

extension NetworkingRegister {
    /// Function to handle URL Session Network Request
    /// - Parameters:
    ///   - requestData: `NetworkRequestType` Object
    ///   - completionHandler: Closure to know the status of network request
    private func registerURLSessionNetworkRequest(requestData: NetworkRequestParams,
                                                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let request = createURLRequest(requestData: requestData) else {
            completionHandler(nil, nil, nil)
            return
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        })
        task.resume()
    }
    
    /// Function to create a URL Request
    /// - Parameter requestData: `NetworkRequestParams` object
    /// - Returns: `URLRequest` Object
    private func createURLRequest(requestData: NetworkRequestParams) -> URLRequest? {
        // TODO:
        // Inhance the logic to support more diverse API calls
        // Currently sufficed in realm of this project.
        guard let stringURL = requestData.url,
              let url = URL(string: stringURL) else {
                  return nil
              }
        var request = URLRequest(url: url,
                                 timeoutInterval: Double.infinity)
        request.httpMethod = requestData.method?.rawValue
        return request
    }
}
