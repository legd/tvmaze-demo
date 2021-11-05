//
//  ShowRouter.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 1/11/21.
//

import Foundation
import Alamofire

enum ShowRouter: Router {
    case allShows
    case showPage
    case search(query: String)

    var path: String {
        switch self {
        case .allShows:
            return "/shows"
        case .showPage:
            return "/shows"
        case .search:
            return "/search/shows"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .showPage:
            var page: Int = 0
            let lastId = TVMazeShows.sharedInstance.showList.last?.id
            var result = Double(lastId! / 250)
            result.round()
            page = Int(result)
            return ["page": page]
        case .search(let query):
            return ["q": query]
        default:
            return [:]
        }
    }
}
