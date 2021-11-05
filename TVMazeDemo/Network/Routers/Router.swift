//
//  Router.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import Foundation
import Alamofire

public protocol Router: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
}

extension Router {
    public func asURLRequest() throws -> URLRequest {
        let url = try ROOT_URL.asURL()
        let request = try URLRequest(url: url.appendingPathComponent(path), method: method)

        guard !parameters.isEmpty else { return request }
        
        if method == .get {
            return try URLEncoding.default.encode(request, with: parameters)
        }
        
        return try JSONEncoding.default.encode(request, with: parameters)
    }
}
