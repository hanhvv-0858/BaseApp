//
//  AppRouter.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = ""
    
    case getAppInfo(parameters: Parameters)
    case readUsers
    case createUser(parameters: Parameters)
    case readUser(id: String)
    case updateUser(id: String, parameters: Parameters)
    case destroyUser(id: String)
    case readPosts
    case createPost(parameters: Parameters)
    case readPost(id: String)
    case updatePost(id: String, parameters: Parameters)
    case destroyPost(id: String)
}

extension Router {
    var method: HTTPMethod {
        switch self {
        case .readUsers,
             .readUser,
             .readPosts,
             .readPost:
            return .get
        case .createUser,
             .createPost:
            return .post
        case .updateUser,
             .updatePost:
            return .put
        case .destroyUser,
             .destroyPost:
            return .delete
            
        case .getAppInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .readUsers:
            return "users"
        case .createUser:
            return "users"
        case .readUser(let username):
            return "users/\(username)"
        case .updateUser(let username, _):
            return "users/\(username)"
        case .destroyUser(let username):
            return "users/\(username)"
        case .readPosts:
            return "posts"
        case .createPost:
            return "posts"
        case .readPost(let id):
            return "posts/\(id)"
        case .updatePost(let id, _):
            return "posts/\(id)"
        case .destroyPost(let id):
            return "posts/\(id)"
        case .getAppInfo(let parameter):
            return "getApp/\(parameter)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: "")
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getAppInfo(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            return urlRequest
        }
        
        return urlRequest
    }
}
