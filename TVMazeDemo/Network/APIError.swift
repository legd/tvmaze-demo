//
//  APIError.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import Foundation

enum APIError: Error {
    case noInternetConnection
    case noDataPermission
    case serverTimeout
    case serverDown
    case other(message: String)
    case custom(message: String, with: Any)
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("noInternetConnection", comment: "")
        case .noDataPermission:
            return NSLocalizedString("noDataPermission", comment: "")
        case .serverTimeout:
            return NSLocalizedString("serverTimeout", comment: "")
        case .serverDown:
            return NSLocalizedString("serverErrorWithoutMessage", comment: "")
        case .other(let message):
            return message
        case .custom(let message, _):
            return message
        }
    }
}

extension APIError {
    init(message: String) {
        self = .other(message: message)
    }
}
