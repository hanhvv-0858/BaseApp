//
//  ApiClients.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//


import Alamofire
import SwiftyJSON

public typealias ResponseHandler = (ResponseObject?) -> Void
public typealias Parameter = Parameters
public typealias NRequest = Request
public typealias DataUpLoad = (data: Data, name: String, fileName: String, mimeType: String)

protocol UploadURLConvertible: URLConvertible {
    func dataUpLoad() -> [DataUpLoad]?
    func parameters() -> Parameters?
}

struct HeaderKey {
    static let ContentType              = "Content-Type"
    static let Authorization            = "Authorization"
    static let Accept                   = "Accept"
}

struct HeaderValue {
    static let ApplicationJson                     = "application/json"
    static let ApplicationOctetStream              = "application/octet-stream"
    static let ApplicationXWWWFormUrlencoded       = "application/x-www-form-urlencoded"
}

enum RequestResult {
    case success
    case error
    case cancelled
}

public enum HttpStatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    case requestTimeout = 408
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case notConnectedToInternet = -1009
    case cancelled = -999
    case timeOut = -1001
    case cannotFindHost = -1003
    case uploadDataError = -90000
    
    init?(statusCode: Int?) {
        guard let _statusCode = statusCode else {
            return nil
        }
        
        // init
        self.init(rawValue: _statusCode)
    }
}

public struct ResponseObject {
    let data: AnyObject?
    let statusCode: HttpStatusCode? // code error, incase success
    let result: RequestResult
    let success: Bool?
    let errorCode: String?
}

struct NetworkManager {
    
    fileprivate static var requestCnt: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if isShowNetworkActivityIndicator == true {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = (requestCnt > 0)
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    static var isShowNetworkActivityIndicator: Bool = true
    
    private static let defaultSessionManager: SessionManager = {
        
        let os = ProcessInfo().operatingSystemVersion
        let version = os.majorVersion + os.minorVersion + os.patchVersion
        
        // defaultHeaders
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders[HeaderKey.Accept] = HeaderValue.ApplicationJson
        defaultHeaders[HeaderKey.ContentType] = HeaderValue.ApplicationJson
        defaultHeaders["client"] = "iOS-\(version)"
        
        // configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.timeoutIntervalForRequest = 30
        
        // sessionManager
        let sessionManager = SessionManager(configuration: configuration)
        
        return sessionManager
    }()
    
    // MARK: - Functions
    private static func analyzeResponse(response: DataResponse<Any>, completionHandler: ResponseHandler?) {
        // http code
        let httpStatusCode = HttpStatusCode(statusCode: response.response?.statusCode)
        
        switch response.result {
        case .success(let value):
            NetworkManager.successWithValue(data: value as AnyObject, httpStatusCode: httpStatusCode, completionHandler: completionHandler)
            
        case .failure(let error):
            NetworkManager.failureWithError(error: error, data: response.data, httpStatusCode: httpStatusCode, completionHandler: completionHandler)
        }
    }
    
    private static func successWithValue(data: AnyObject, httpStatusCode: HttpStatusCode?, completionHandler: ResponseHandler?) {
        let json = JSON(data)
        let success = json[JSONKey.success].bool
        let errorCode = json[JSONKey.errorCode].string
        // create obj response
        let responseObject = ResponseObject(data: data, statusCode: httpStatusCode, result: RequestResult.success, success: success, errorCode: errorCode)
        
        // block
        completionHandler?(responseObject)
        
    }
    
    private static func failureWithError(error: Error?, data: Data? = nil, httpStatusCode: HttpStatusCode?, completionHandler: ResponseHandler?) {
        var errorCode: HttpStatusCode? = httpStatusCode
        var requestResult: RequestResult = RequestResult.error
        var errorData: AnyObject? = nil
        
        // check error code
        if error?._code == NSURLErrorTimedOut {  // Time out
            errorCode = HttpStatusCode(rawValue: NSURLErrorTimedOut)
            requestResult = .error
        } else if error?._code == NSURLErrorCancelled {  // Cancelled
            errorCode = HttpStatusCode(rawValue: NSURLErrorCancelled)
            requestResult = .cancelled
        } else if error?._code == NSURLErrorNotConnectedToInternet { // Not connected to internet
            errorCode = HttpStatusCode(rawValue: NSURLErrorNotConnectedToInternet)
            requestResult = .error
        } else if error?._code == NSURLErrorCannotFindHost { // Can not Find Host
            errorCode = HttpStatusCode(rawValue: NSURLErrorCannotFindHost)
            requestResult = .error
        } else {  // Orther
            if let _data = data {
                do {
                    errorData = try JSONSerialization.jsonObject(with: _data, options: []) as AnyObject
                } catch {
                }
            }
        }
        
        // create obj response
        let responseObject = ResponseObject(data: errorData, statusCode: errorCode, result: requestResult, success: nil, errorCode: nil)
        
        // block
        completionHandler?(responseObject)
    }
    
    // MARK: - Request
    @discardableResult
    static func request(urlRequest: URLRequestConvertible, completionHandler: ResponseHandler? = nil) -> Request? {
        requestCnt += 1
        // Request
        let manager = NetworkManager.defaultSessionManager
        // request
        return manager.request(urlRequest).validate().responseJSON { (response) in
            // analyze response
            NetworkManager.analyzeResponse(response: response, completionHandler: completionHandler)
            requestCnt -= 1
        }
    }
}
