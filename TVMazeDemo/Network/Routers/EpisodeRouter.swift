//
//  EpisodeRouter.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import Foundation
import Alamofire

enum EpisodeRouter: Router {
    case allEpisodes(showId: Int)

    var path: String {
        switch self {
        case .allEpisodes(let showId):
            return "/shows/\(showId)/episodes"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        return [:]
    }
}
