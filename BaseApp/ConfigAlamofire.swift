//
//  ConfigAlamofire.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit
extension DataRequest {
    
    public func responseSwiftyJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler:@escaping (JSON?) -> Void)
        -> Self {
            return response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(options: options), completionHandler: { (response) in
                DispatchQueue.global(qos: .default).async(execute: {
                    var responseJSON: JSON?
                    if response.result.isFailure {
                        responseJSON = JSON.null
                    } else {
                        if let json = response.result.value {
                            responseJSON = JSON(json)
                        }
                    }
                    (queue ?? DispatchQueue.main).async(execute: {
                        completionHandler(responseJSON)
                    })
                })
            })
    }
}

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

extension DataRequest {
    @discardableResult
    func responseObject<T: ResponseObjectSerializable>(queue: DispatchQueue? = nil,
                                                       completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {
                return .failure(BackendError.network(error: error!))
                
            }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(BackendError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }
        
        return response(queue: queue,responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

// MARK : Handle error
extension UIViewController {
    
    @discardableResult
    func handleCodeError(errorObject: ResponseObject?, completion: (() -> Void)?) -> Bool? {
        
        if let message = self.getErrorMessage(errorObject?.statusCode.debugDescription) {
            UIAlertController.showAlertWithAction(self, title: nil, message: message, buttonTitle: "OK", okHandle: { (action) in
                completion?()
            })
            return true
        }
        return nil
    }
    
    @discardableResult
    func handleResponseError(responseObject: ResponseObject?, completion: (() -> Void)?) -> Bool? {
        if responseObject?.statusCode == HttpStatusCode.unauthorized {
            return true
        } else if responseObject?.statusCode == HttpStatusCode.timeOut {
            return true
        }
        return nil
    }
    fileprivate func getErrorMessage(_ error_code: String?) -> String? {
        return nil
    }
}
