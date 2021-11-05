//
//  EpisodesRequest.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import Foundation
import SwiftyJSON

class EpisodesRequest {
    static let apiService = NAPIService<EpisodeRouter>()
    
    static func getAllEpisodes(showId: Int, whileLoading: @escaping () -> Void, whenLoaded: @escaping (_ episodes: [Int: [Episode]]) -> Void, onError: @escaping (String, [Int: Double]?) -> Void) {
        whileLoading()
        let _ = apiService.request(.allEpisodes(showId: showId)) { (data, error) in
            if let episodes = data {

                var seasons = [Int: [Episode]]()
                var episodeList: [Episode] = Array()
                var season = 1
                for episode in episodes.array! {
                    let newEpisode = Episode(withJSON: episode)
                    if season == newEpisode.season {
                        episodeList.append(newEpisode)
                    } else {
                        seasons[season] = episodeList
                        episodeList.removeAll()
                        season = newEpisode.season
                        episodeList.append(newEpisode)
                    }
                }
                
                whenLoaded(seasons)
            } else if let _error = error {
                onError(_error.localizedDescription, nil)
            }
        }
    }
}
